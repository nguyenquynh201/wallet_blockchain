import 'package:wallet_blockchain/utils/constants.dart';

class NotificationEntity {
  String? id;
  String? title;
  String? description;
  bool? isRead;
  String? createBy;
  num? numberCoin;
  DateTime? createdAt;

  NotificationEntity(
      {this.id,
      this.title,
      this.description,
      this.isRead,
      this.createBy,
      this.numberCoin,
      this.createdAt});

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
        id: json["id"],
        title: json["title"],
        description: json["description"] ?? Constants.EMPTY_STRING,
        isRead: json["isRead"] ?? false,
        createBy: json["createBy"],
        numberCoin: json["numberCoin"],
        createdAt: DateTime.parse(json["createdAt"]));
  }

  NotificationEntity.fromSnapshot(snapshot)
      : createBy = snapshot.data()["createBy"],
        createdAt = snapshot.data()["createdAt"],
        description = snapshot.data()["description"],
        isRead = snapshot.data()["isRead"],
        numberCoin = snapshot.data()["numberCoin"],
        title = snapshot.data()["title"];

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "title": title,
      "description": description ?? Constants.EMPTY_STRING,
      "isRead": isRead ?? false,
      "createBy": createBy,
      "numberCoin": numberCoin,
      "createdAt": createdAt.toString()
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "isRead": isRead,
    };
  }
}
