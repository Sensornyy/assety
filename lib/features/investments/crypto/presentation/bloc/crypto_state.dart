part of 'crypto_bloc.dart';

@freezed
class CryptoState with _$CryptoState {
  const factory CryptoState.initial() = _Initial;

  const factory CryptoState.loading() = _Loading;

  const factory CryptoState.success(List<TokenEntity> tokens) = _Success;

  const factory CryptoState.notFound() = _NotFound;

  const factory CryptoState.failure() = _Failure;
}
