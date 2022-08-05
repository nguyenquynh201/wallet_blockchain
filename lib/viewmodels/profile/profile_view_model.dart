import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/string_utils.dart';
import 'package:wallet_blockchain/utils/validator.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';

class ProfileViewModel extends BaseViewModel {
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
  }

  List<UserEntity> _user = [];

  List<UserEntity> get user => List.from(_user);

  UserEntity? _entity;

  UserEntity? get entity => _entity;

  void getUserList({required UserEntity entity}) async {
    setState(ViewState.busy);
    try {
      var data = await FirebaseFirestore.instance.collection('users').get();
      List<UserEntity> userList =
          List.from(data.docs.map((doc) => UserEntity.fromSnapshot(doc)));
      userList.forEach((element) {
        if (element.id != entity.id) {
          _user.add(element);
        }
        if (element.id == entity.id) {
          _entity = element;
        }
      });
    } catch (e) {}
    setState(ViewState.success);
  }

  String _coinSend = "";
  ValidateCoinState _validateCoinState = ValidateCoinState.none;

  ValidateCoinState get validateCoinState => _validateCoinState;

  void onChangCoin(String value) {
    int parseValue = int.parse(value);
    if (parseValue > _entity!.coin!) {
      _coinSend = value;
      _validateCoinState = ValidateCoinState.notCorrect;
    } else {
      _validateCoinState = ValidateCoinState.none;
      _coinSend = value;
      totalCoinSend();
    }
    updateUI();
  }

  void onFocusCoin() {
    _validateCoinState = ValidateCoinState.none;
    updateUI();
  }

  String _idUserSend = "";

  UserEntity? _entitySendCoin;

  UserEntity? get entitySendCoin => _entitySendCoin;

  void onChangUserId(String value) async {
    _idUserSend = value;

    /// get user to send coin
    var data =
        await FirebaseFirestore.instance.collection('users').doc(value).get();
    _entitySendCoin = UserEntity.fromSnapshot(data);
    updateUI();
  }

  List<String> walletCoin = ["Bitcoin", "Ether", "Bitcoin Cash"];
  String _walletCoin = "";

  void onChangWalletCoin(String value) {
    _walletCoin = value;
    totalCoinSend();
    updateUI();
  }

  bool get isEnable {
    return !Validators.isEmpty(_coinSend) &&
        !Validators.isEmpty(_walletCoin) &&
        !Validators.isEmpty(_idUserSend);
  }

  double _totalCoin = 0;

  double get totalCoin => _totalCoin;

  void totalCoinSend() {
    if (int.parse(_coinSend) < 10) {
      /// coin <10 transaction fee free
      _totalCoin = double.parse(_coinSend);
    } else if (int.parse(_coinSend) <= 20 && int.parse(_coinSend) >= 10) {
      ///  10 <= coin <= 20 transaction fee 5 %
      _totalCoin = (int.parse(_coinSend) - (2 / 100 * 100));
    } else {
      /// coin > 20 transaction fee 5 %
      _totalCoin = (int.parse(_coinSend) - (5 / 100 * 100));
    }

    updateUI();
  }

  void sendCoinToUser() async {
    if (int.parse(_coinSend) > _entity!.coin!) {
      _validateCoinState = ValidateCoinState.notCorrect;
      setState(ViewState.success);
      return;
    }
    NavigationService.instance
        .showProgressingDialog(context: context, message: "Sending data....");
    try {
      final totalNewUserCurrent = _entity!.coin! - _totalCoin;
      final totalNewUserSend = _entitySendCoin!.coin! + _totalCoin;
      UserEntity _entityCurrent = UserEntity(coin: totalNewUserCurrent);
      UserEntity _entitySend = UserEntity(coin: totalNewUserSend);

      /// update receiver wallet
      FirebaseFirestore.instance
          .collection('users')
          .doc(_idUserSend)
          .update(_entitySend.toJsonUpdate());

      /// update wallet current
      FirebaseFirestore.instance
          .collection('users')
          .doc(_entity!.id)
          .update(_entityCurrent.toJsonUpdate());
      Future.delayed(const Duration(seconds: 1));
      NavigationService.instance.hideProgressingLoad(context);
      NavigationService.instance.backNavigation(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        padding: EdgeInsets.only(left: 100),
        content: Text("Sending data successfully"),
      ));
    } catch (e) {}
  }

  void navigationToSignInView({required BuildContext context}) {
    NavigationService.instance.NavigationLoginView(context);
  }
}
