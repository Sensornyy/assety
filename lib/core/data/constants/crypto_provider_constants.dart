abstract class CryptoProviderConstants {
  static const String apiKey = 'd352539c-8ae6-4313-8c50-5b7a1176c6d0';
  static const String apiHeader = 'X-CMC_PRO_API_KEY';

  static const String baseV1Url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/';
  static const String getTokenEndpoint = '${baseV1Url}quotes/latest';
  static const String getTokensEndpoint = '${baseV1Url}listings/latest';

  static const String baseV2Url = 'https://pro-api.coinmarketcap.com/v2/cryptocurrency/';
  static const String getMetadataEndpoint = '${baseV2Url}info';
}
