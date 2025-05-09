import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/investments/crypto/domain/entity/token_entity.dart';

abstract class CryptoRepository {
  Future<Result<List<TokenEntity>>> getTop100Tokens();

  Future<Result<TokenEntity>> getToken(String symbol);
}
