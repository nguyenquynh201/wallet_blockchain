import 'package:wallet_blockchain/data/entity/quote_entity.dart';

class DataEntity {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int numMarketPairs;
  final String dateAdded;
  final List<dynamic> tags;
  final int maxSupply;
  final num circulatingSupply;
  final num totalSupply;

  final int cmcRank;
  final String lastUpdated;
  final QuoteEntity quoteModel;

  DataEntity(
      this.id,
      this.name,
      this.symbol,
      this.slug,
      this.numMarketPairs,
      this.dateAdded,
      this.tags,
      this.maxSupply,
      this.circulatingSupply,
      this.totalSupply,
      this.cmcRank,
      this.lastUpdated,
      this.quoteModel);
  factory DataEntity.fromJson(Map<String, dynamic> json) {
    return DataEntity(
      json["id"],
      json["name"],
      json["symbol"],
      json["slug"],
      json["num_market_pairs"],
      json["date_added"],
      json["tags"],
      json["max_supply"] == null ? 0 : json["max_supply"],
      json["circulating_supply"],
      json["total_supply"],
      json["cmc_rank"],
      json["last_updated"],
      QuoteEntity.fromJson(json["quote"]),
    );
  }
}