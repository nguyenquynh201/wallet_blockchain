import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/views/screens/auth/sign_in_view.dart';
import 'package:wallet_blockchain/views/screens/home/home_view.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const SignInView();
          }
        },
      ),
    );
  }
}
