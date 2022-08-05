import 'package:wallet_blockchain/data/entity/usd_entity.dart';

class QuoteEntity {
  final UsdEntity usdEntity;

  QuoteEntity({
    required this.usdEntity,
  });
  factory QuoteEntity.fromJson(Map<String, dynamic> json) {
    return QuoteEntity(
      usdEntity: UsdEntity.fromJson(json["USD"]),
    );
  }
}