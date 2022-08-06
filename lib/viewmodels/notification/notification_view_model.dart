import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallet_blockchain/data/entity/notification_entity.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';

class NotificationViewModel extends BaseViewModel {
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
  }

  List<NotificationEntity> _notification = [];

  List<NotificationEntity> get notification => List.from(_notification);

  List<String> idDocs = [];

  UserEntity? _entity;

  UserEntity? get entity => _entity;

  void getNotificationById({required String id}) async {
    setState(ViewState.busy);
    try {
      /// get data notification
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('notification')
          .get();
      idDocs = List.from(data.docs.map((e) => e.id));
      List<NotificationEntity> entity = List.from(
          data.docs.map((e) => NotificationEntity.fromJson(e.data())));
      _notification = entity;
      print(_notification);
      var dataUser =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      _entity = UserEntity.fromJson(dataUser.data()!);
      print(_entity);
    } catch (e) {}
    setState(ViewState.success);
  }

  void onClickDone(
      {required NotificationEntity entity, required String idUser , required int index}) async {
    setState(ViewState.busy);
    NavigationService.instance
        .showProgressingDialog(context: context, message: "Receive data....");
    try {
      num totalCoin = _entity!.coin! + entity.numberCoin!;
      UserEntity _entityCurrent = UserEntity(coin: totalCoin);
      NotificationEntity _notification = NotificationEntity(isRead: true);

      /// update coin user receive
      FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .update(_entityCurrent.toJsonUpdate());

      /// update isRead true
      FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .collection("notification")
          .doc(idDocs[index])
          .update(_notification.toJsonUpdate());
      Future.delayed(const Duration(seconds: 1));
      NavigationService.instance.hideProgressingLoad(context);
      NavigationService.instance.backNavigation(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        padding: EdgeInsets.only(left: 100),
        content: Text("Receive data successfully"),
      ));
    } catch (e) {}
    setState(ViewState.success);
  }

// void onClickNoDone({required String id,required NotificationEntity entity}) async {
//   setState(ViewState.busy);
//   try {
//
//   } catch (e) {}
//   setState(ViewState.success);
// }
}
