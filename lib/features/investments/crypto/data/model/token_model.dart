import 'package:assety/features/investments/crypto/domain/entity/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({
    required super.name,
    required super.price,
    required super.logo,
    required super.symbol,
    required super.dailyChange,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    final usd = json['quote']['USD'];

    return TokenModel(
      name: json['name'] as String,
      price: usd['price'] as double,
      logo: json['symbol'] as String,
      symbol: json['symbol'] as String,
      dailyChange: (usd['percent_change_24h'] as num).toDouble(),
    );
  }

  TokenModel copyWith({
    String? name,
    double? price,
    String? logo,
    String? symbol,
    double? dailyChange,
  }) {
    return TokenModel(
      name: name ?? this.name,
      price: price ?? this.price,
      logo: logo ?? this.logo,
      symbol: symbol ?? this.symbol,
      dailyChange: dailyChange ?? this.dailyChange,
    );
  }

  @override
  String toString() {
    return '________\nTokenModel\nname: $name, \nprice: $price, \nlogo: $logo, \nsymbol: $symbol, \ndailyChange: $dailyChange\n________';
  }
}
