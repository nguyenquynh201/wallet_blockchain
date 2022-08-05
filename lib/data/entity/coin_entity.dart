import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/data/entity/status_entity.dart';

class CoinEntity {
  final StatusEntity statusModel;
  final List<DataEntity> dataModel;

  CoinEntity({
    required this.statusModel,
    required this.dataModel,
  });
  factory CoinEntity.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<DataEntity> dataModelList =
    dataList.map((e) => DataEntity.fromJson(e)).toList();
    return CoinEntity(
      statusModel: StatusEntity.fromJson(json["status"]),
      dataModel: dataModelList,
    );
  }
  CoinEntity.withError(String error)
      : statusModel = StatusEntity(error, 0, error, 0, 0, error, 0),
        dataModel = [];
}