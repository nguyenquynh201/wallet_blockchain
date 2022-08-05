import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BlockChainApp());
}

class BlockChainApp extends StatelessWidget {
  const BlockChainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          if (constraints.maxWidth == 0) {
            return const SizedBox.shrink();
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: NavigationService.instance.routerBuilder,
            );
          }
        },
      ),
    );
  }
}
