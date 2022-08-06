import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet_blockchain/data/entity/chart_entity.dart';
import 'package:wallet_blockchain/data/entity/coin_entity.dart';
import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/data/repository/coin_responsitory.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
    _fetchDataCoin();
  }

  List<DataEntity> _coin = [];

  List<DataEntity> get coin => List.from(_coin);

  void _fetchDataCoin() async {
    setState(ViewState.busy);
    try {
      final coin = await CoinRepository.instance.getDataCoin();
      _coin = coin.dataModel;
    } catch (e) {}
    setState(ViewState.success);
  }
  void navigationToNotificationView({required String id}) {
    NavigationService.instance.navigationNotificationView(context , arguments: {
      Constants.USER_ID : id
    });
  }
}
