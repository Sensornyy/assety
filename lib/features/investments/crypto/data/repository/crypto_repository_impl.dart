import 'package:assety/core/data/constants/crypto_provider_constants.dart';
import 'package:assety/core/data/error_handler/exceptions.dart';
import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/data/managers/dio_manager.dart';
import 'package:assety/features/investments/crypto/data/model/token_model.dart';
import 'package:assety/features/investments/crypto/domain/repository/crypto_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CryptoRepository)
class CryptoRepositoryImpl implements CryptoRepository {
  final DioManager _dioManager;

  CryptoRepositoryImpl(this._dioManager);

  @override
  Future<Result<List<TokenModel>>> getTop100Tokens() async {
    try {
      final tokenModels = await _fetchTop100Tokens();
      final tokenSymbols = tokenModels.map((token) => token.symbol).toList();
      final tokenLogos = await _fetchTokensLogos(tokenSymbols);
      final mergedTokens = _mergeTokensWithLogos(tokenModels, tokenLogos);

      return Result.successWithData(mergedTokens);
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }

  Future<List<TokenModel>> _fetchTop100Tokens() async {
    final response = await _dioManager.dio.get(
      CryptoProviderConstants.getTokensEndpoint,
      queryParameters: {'limit': 100},
      options: Options(
        headers: {CryptoProviderConstants.apiHeader: CryptoProviderConstants.apiKey},
      ),
    );

    final data = response.data['data'] as List;
    return data.map((json) => TokenModel.fromJson(json)).toList();
  }

  Future<Map<String, String>> _fetchTokensLogos(List<String> symbols) async {
    final response = await _dioManager.dio.get(
      CryptoProviderConstants.getMetadataEndpoint,
      queryParameters: {'symbol': symbols.join(',')},
      options: Options(
        headers: {CryptoProviderConstants.apiHeader: CryptoProviderConstants.apiKey},
      ),
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return data.map((key, value) => MapEntry<String, String>(key, value[0]['logo'] as String));
  }

  List<TokenModel> _mergeTokensWithLogos(List<TokenModel> tokens, Map<String, String> logos) {
    return tokens.map((token) {
      final logo = logos[token.symbol] ?? '';
      return token.copyWith(logo: logo);
    }).toList();
  }

  @override
  Future<Result<TokenModel>> getToken(String symbol) async {
    try {
      final token = await _fetchToken(symbol);
      final logo = await _fetchTokenLogo(symbol);
      final mergedToken = _mergeTokenWithLogo(token, logo);

      return Result.successWithData(mergedToken);
    } on AssetNotFoundException catch (e) {
      return Result.success();
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }

  Future<TokenModel> _fetchToken(String symbol) async {
    final response = await _dioManager.dio.get(
      CryptoProviderConstants.getTokenEndpoint,
      queryParameters: {'symbol': symbol},
      options: Options(
        headers: {CryptoProviderConstants.apiHeader: CryptoProviderConstants.apiKey},
      ),
    );

    final data = response.data['data'][symbol.toUpperCase()];
    if (data == null) {
      throw AssetNotFoundException();
    }
    return TokenModel.fromJson(data);
  }

  Future<String> _fetchTokenLogo(String symbol) async {
    final response = await _dioManager.dio.get(
      CryptoProviderConstants.getMetadataEndpoint,
      queryParameters: {'symbol': symbol},
      options: Options(
        headers: {CryptoProviderConstants.apiHeader: CryptoProviderConstants.apiKey},
      ),
    );

    final data = response.data['data'][symbol.toUpperCase()][0] as Map<String, dynamic>;
    return data['logo'];
  }

  TokenModel _mergeTokenWithLogo(TokenModel token, String logo) {
    return token.copyWith(logo: logo);
  }
}
