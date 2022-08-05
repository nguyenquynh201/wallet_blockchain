import 'package:flutter/material.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class HomeHeader extends StatefulWidget {
  final UserEntity entity;

  const HomeHeader({Key? key, required this.entity}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        color: UIColors.colorBackground,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Row(
        children: [
          _buildThumbnail(),
          SizedBox(
            width: 5,
          ),
          _buildName(profileName: widget.entity.name!)
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return InkWell(
      onTap: () {
        NavigationService.instance.NavigationProfileView(context,
            arguments: {Constants.ENTITY: widget.entity});
      },
      child: SizedBox(
        height: 48,
        width: 48,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              AssetImages.defaultAccount,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget _buildName({required String profileName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: UIText(
        profileName,
        style: const TextStyle(
          color: UIColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
