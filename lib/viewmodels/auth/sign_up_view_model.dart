import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/utils/validator.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
  }

  /// secure password
  bool _securePassword = true;

  bool get securePassword => _securePassword;

  void updateSecurePassword(bool value) {
    _securePassword = value;
    setState(ViewState.success);
  }

  String _name = Constants.EMPTY_STRING;

  void onNameChange(String value) {
    _name = value.trim();
    setState(ViewState.success);
  }

  String _email = Constants.EMPTY_STRING;

  void onEmailChange(String value) {
    _email = value.trim();
    setState(ViewState.success);
  }

  String _password = Constants.EMPTY_STRING;

  void onPasswordChange(String value) {
    _password = value.trim();
    setState(ViewState.success);
  }

  String _phone = Constants.EMPTY_STRING;

  void onPhoneChang(String value) {
    _phone = value;
    setState(ViewState.success);
  }

  bool get isSignInButtonEnabled {
    return !Validators.isEmpty(_name) &&
        !Validators.isEmpty(_password) &&
        !Validators.isEmpty(_email) &&
        !Validators.isEmpty(_phone);
  }

  ValidateState _validateNameState = ValidateState.none;

  ValidateState get validateNameState => _validateNameState;

  void restoreValidateNameState() {
    _validateNameState = ValidateState.none;
    setState(ViewState.success);
  }

  ValidateEmailState _validateEmailState = ValidateEmailState.none;

  ValidateEmailState get validateEmailState => _validateEmailState;

  void restoreValidateEmailState() {
    _validateEmailState = ValidateEmailState.none;
    setState(ViewState.success);
  }

  ValidatePasswordState _validatePasswordState = ValidatePasswordState.none;

  ValidatePasswordState get validatePasswordState => _validatePasswordState;

  void restoreValidatePasswordState() {
    _validatePasswordState = ValidatePasswordState.none;
    setState(ViewState.success);
  }

  ValidatePhoneState _validatePhoneState = ValidatePhoneState.none;

  ValidatePhoneState get validatePhoneState => _validatePhoneState;

  void restoreValidatePhoneState() {
    _validatePhoneState = ValidatePhoneState.none;
    setState(ViewState.success);
  }

  bool get isCreateButtonEnabled {
    return !Validators.isEmpty(_email) &&
        !Validators.isEmpty(_phone) &&
        !Validators.isEmpty(_password);
  }

  void clickRegister() async {
    if (!Validators.isEmail(_email)) {
      _validateEmailState = ValidateEmailState.invalid;
      setState(ViewState.success);
      return;
    }
    if (_password.length < 6) {
      _validatePasswordState = ValidatePasswordState.short;
      setState(ViewState.success);
      return;
    } else {
      _validatePasswordState = ValidatePasswordState.none;
    }

    if (!Validators.isValidPhone(_phone)) {
      _validatePhoneState = ValidatePhoneState.invalid;
      setState(ViewState.success);
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.toString().trim(),
              password: _password.toString().trim())
          .then((value) {
        UserEntity userEntity = UserEntity(
            id: value.user!.uid,
            email: _email.toString().trim(),
            coin: 100,
            name: _name.toString().trim(),
            phone: _phone.toString().trim(),
            password: _password.toString().trim());
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set(userEntity.toJson());
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        padding: EdgeInsets.only(left: 150),
        content: Text("Register Success"),
      ));
      await Future.delayed(const Duration(seconds: 2));
      NavigationService.instance.NavigationLoginView(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.only(left: 150),
        content: Text(e.toString()),
      ));
      print(e);
    }
  }

  displayToast({required String message, required BuildContext context}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.green,
      textColor: Colors.black26,
      fontSize: 16.0,
    );
  }
}
