import 'package:dio/dio.dart';
import 'package:wallet_blockchain/data/entity/coin_entity.dart';

class CoinRepository {
  CoinRepository._();

  static CoinRepository? _instance;

  static CoinRepository get instance {
    _instance ??= CoinRepository._();
    return _instance!;
  }

  static String kUrl = "https://pro-api.coinmarketcap.com/v1/";
  final String apiKey = "257bcb4c-5bc8-411f-ada5-a2b854ec66df";
  var currencyListingAPI = '${kUrl}cryptocurrency/listings/latest?limit=10';
  Dio _dio = Dio();

  Future<CoinEntity> getDataCoin() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return CoinEntity.fromJson(response.data);
    } catch (e) {
      return CoinEntity.withError(e.toString());
    }
  }
}
