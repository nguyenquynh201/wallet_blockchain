import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/utils/validator.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';

class SignInViewModel extends BaseViewModel {
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

  bool get isLoginButtonEnabled {
    return !Validators.isEmpty(_password) && !Validators.isEmpty(_email);
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

  void navigateToSignUpScreen() {
    NavigationService.instance.NavigationSignUpView(context);
  }
  bool get isEnable {
    return !Validators.isEmpty(_email) && !Validators.isEmpty(_password);
  }
  void clickLogin() async {
    final login =  await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.toString().trim(), password: _password.toString().trim());
    if(login != null) {
      NavigationService.instance.NavigationHomeView(context);
    }
  }
}
