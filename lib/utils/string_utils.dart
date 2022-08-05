import 'package:flutter/cupertino.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/utils/constants.dart';

class StringUtils {
  static bool isEmpty(String? s) {
    if (s == null) return true;
    if (s.trim().isEmpty) return true;
    return false;
  }

  //InvalidEmailState
  static String toInvalidPasswordString(
      ValidatePasswordState state, BuildContext context) {
    switch (state) {
      case ValidatePasswordState.invalid:
        return "Invalid password";
      case ValidatePasswordState.notCorrect:
        return "Password do not match";
      case ValidatePasswordState.short:
        return "Password must be at least 6 characters";
      case ValidatePasswordState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }

  //InvalidEmailState
  static String toInvalidEmailString(
      ValidateEmailState state, BuildContext context) {
    switch (state) {
      case ValidateEmailState.invalid:
        return "Invalid email format";
      case ValidateEmailState.notCorrect:
        return "Email not found";
      case ValidateEmailState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }

  //InvalidPhoneState
  static String toInvalidPhoneString(
      ValidatePhoneState state, BuildContext context) {
    switch (state) {
      case ValidatePhoneState.invalid:
        return "Invalid phone number";
      case ValidatePhoneState.notCorrect:
        return "Phone number not found";
      case ValidatePhoneState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }

  static String toInvalidCoinString(
      ValidateCoinState state, BuildContext context) {
    switch (state) {
      case ValidateCoinState.invalid:
        return "Invalid coin number";
      case ValidateCoinState.notCorrect:
        return "Your coins are not enough!!";
      case ValidateCoinState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }
}
