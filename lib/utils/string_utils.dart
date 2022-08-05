import 'package:flutter/cupertino.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/utils/constants.dart';

class StringUtils {
  static bool isEmpty(String? s) {
    if(s == null) return true;
    if(s.trim().isEmpty) return true;
    return false;
  }
  //InvalidEmailState
  static String toInvalidPasswordString(ValidatePasswordState state,BuildContext context) {
    switch (state) {
      case ValidatePasswordState.invalid:
        return "Mật khẩu không hợp lệ";
      case ValidatePasswordState.notCorrect:
        return "Mật khẩu không trùng khớp";
      case ValidatePasswordState.short:
        return "Mật khẩu phải ít nhất 6 kí tự";
      case ValidatePasswordState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }
  //InvalidEmailState
  static String toInvalidEmailString(ValidateEmailState state,BuildContext context) {
    switch (state) {
      case ValidateEmailState.invalid:
        return "Email không hợp lệ";
      case ValidateEmailState.notCorrect:
        return "Email không đúng";
      case ValidateEmailState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }
  //InvalidPhoneState
  static String toInvalidPhoneString(ValidatePhoneState state,BuildContext context) {
    switch (state) {
      case ValidatePhoneState.invalid:
        return "Số điện thoại không hợp lệ";
      case ValidatePhoneState.notCorrect:
        return "Số điện thoại không đúng";
      case ValidatePhoneState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }  static String toInvalidCoinString(ValidateCoinState state,BuildContext context) {
    switch (state) {
      case ValidateCoinState.invalid:
        return "Số coin nhập không hợp lệ";
      case ValidateCoinState.notCorrect:
        return "Số coin của bạn không đủ!!";
      case ValidateCoinState.none:
      default:
        return Constants.EMPTY_STRING;
    }
  }
}