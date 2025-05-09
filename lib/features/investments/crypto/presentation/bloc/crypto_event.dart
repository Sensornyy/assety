part of 'crypto_bloc.dart';

@freezed
class CryptoEvent with _$CryptoEvent {
  const factory CryptoEvent.getTop100Tokens() = _GetTop100Tokens;

  const factory CryptoEvent.getToken(String symbol) = _GetToken;
}
