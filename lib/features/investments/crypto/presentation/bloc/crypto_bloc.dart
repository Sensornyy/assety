import 'package:assety/core/di/init_di.dart';
import 'package:assety/features/investments/crypto/domain/entity/token_entity.dart';
import 'package:assety/features/investments/crypto/domain/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_bloc.freezed.dart';
part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final _repository = locator.get<CryptoRepository>();

  final List<TokenEntity> _tokens = [];

  List<TokenEntity> get tokens => List.unmodifiable(_tokens);

  void _updateTokens(List<TokenEntity> tokens) {
    _tokens.clear();
    _tokens.addAll(tokens);
  }

  CryptoBloc() : super(const CryptoState.initial()) {
    on<CryptoEvent>(
      (event, emit) async {
        await event.when(
          getTop100Tokens: () async {
            emit(
              CryptoState.loading(),
            );

            final result = await _repository.getTop100Tokens();

            await result.when(
              successWithData: (tokens) {
                _updateTokens(tokens);

                emit(
                  CryptoState.success(tokens),
                );
              },
              failure: () => emit(
                CryptoState.failure(),
              ),
            );
          },
          getToken: (symbol) async {
            emit(
              CryptoState.loading(),
            );

            final result = await _repository.getToken(symbol);

            await result.when(
              successWithData: (token) {
                _updateTokens([token]);

                emit(
                  CryptoState.success([token]),
                );
              },
              success: () => emit(
                CryptoState.notFound(),
              ),
              failure: () => emit(
                CryptoState.failure(),
              ),
            );
          },
        );
      },
    );
  }
}
