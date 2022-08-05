import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2) , () => NavigationService.instance.NavigationMainView(context));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SvgPicture.asset(AssetImages.iconLogo , height: 120),
        ),
      ),
    );
  }
}
