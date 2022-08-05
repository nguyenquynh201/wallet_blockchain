import 'package:wallet_blockchain/utils/constants.dart';

class Validators {
  Validators._();
  static bool isEmpty(String? value) {
    if(value == null) return true;
    return value == Constants.EMPTY_STRING;
  }
  static bool isEmail(String email) {

    if (isEmpty(email)) {
      return false;
    }

    final emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegexp.hasMatch(email);
  }

  static bool isValidPassword(String password) {

    if (isEmpty(password)) {
      return false;
    }

    if(password.length < 6){
      return password.length >= Constants.MINIMUM_PASSWORD_LENGTH;
    }

    return password.length >= Constants.MINIMUM_PASSWORD_LENGTH;
  }
  static bool isValidPhone(String phone) {

    if (isEmpty(phone)) {
      return false;
    }
    return phone.length >= Constants.MINIMUM_PHONE_LENGTH;
  }
}