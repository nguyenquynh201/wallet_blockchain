import 'package:flutter/material.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/views/screens/auth/sign_in_view.dart';
import 'package:wallet_blockchain/views/screens/auth/sign_up_view.dart';
import 'package:wallet_blockchain/views/screens/home/home_view.dart';
import 'package:wallet_blockchain/views/screens/home/main_view.dart';
import 'package:wallet_blockchain/views/screens/notification/notification_view.dart';
import 'package:wallet_blockchain/views/screens/profile/profile_view.dart';
import 'package:wallet_blockchain/views/screens/splash_view.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class NavigationService {
  static NavigationService _instance = NavigationService._internal();

  static NavigationService get instance => _instance;

  const NavigationService._internal();

  factory NavigationService() {
    if (_instance == null) {
      _instance = NavigationService._internal();
    }
    return _instance;
  }

  static const String SPLASH_PROGRESS_ROUTER = "/SPLASH_PROGRESS_ROUTER";
  static const String LOGIN_ROUTER = "/LOGIN_ROUTER";
  static const String HOME_ROUTER = "/HOME_ROUTER";
  static const String SIGN_UP_ROUTER = "/SIGN_UP_ROUTER";
  static const String MAIN_ROUTER = "/MAIN_ROUTER";
  static const String PROFILE_ROUTE = "/PROFILE_ROUTE";
  static const String NOTIFICATION_ROUTE = "/NOTIFICATION_ROUTE";

  String initialRouterApp() => SPLASH_PROGRESS_ROUTER;

  Route<dynamic> routerBuilder(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SPLASH_PROGRESS_ROUTER:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case LOGIN_ROUTER:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case SIGN_UP_ROUTER:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case MAIN_ROUTER:
        return MaterialPageRoute(builder: (_) => const MainView());
      case PROFILE_ROUTE:
        final arg = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ProfileView(
                  entity: arg[Constants.ENTITY],
                ));
      case NOTIFICATION_ROUTE:
        final arg = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => NotificationView(
                  idEntity: arg[Constants.USER_ID],
                ));
      case HOME_ROUTER:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }

  void NavigationLoginView(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTER, (route) => false);
  }

  void NavigationMainView(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, MAIN_ROUTER, (route) => false);
  }

  void NavigationHomeView(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, HOME_ROUTER, (route) => false);
  }

  void NavigationSignUpView(BuildContext context) {
    Navigator.pushNamed(context, SIGN_UP_ROUTER);
  }

  void NavigationProfileView(BuildContext context, {Object? arguments}) {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: arguments);
  }

  void navigationNotificationView(BuildContext context, {Object? arguments}) {
    Navigator.pushNamed(context, NOTIFICATION_ROUTE , arguments: arguments);
  }

  void backNavigation(BuildContext context) {
    Navigator.pop(context);
  }

  void hideProgressingLoad(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void showProgressingDialog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: UIText(
                    message,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
