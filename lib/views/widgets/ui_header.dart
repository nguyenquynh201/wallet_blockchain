import 'package:flutter/material.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/services/navigation_service.dart';
import 'package:wallet_blockchain/utils/constants.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class HomeHeader extends StatefulWidget {
  final UserEntity entity;
  final VoidCallback onPressed;
  const HomeHeader({Key? key, required this.entity, required this.onPressed}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: const EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        color: UIColors.colorBackground,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildThumbnail(),
              const SizedBox(
                width: 5,
              ),
              _buildName(profileName: widget.entity.name!)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,top: 10),
            child: _buildIconButton(
                child: Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AssetImages.iconNotification,
                    fit: BoxFit.contain,
                    color: UIColors.white,
                  ),
                ),
                onPressed: widget.onPressed
            ),
          ),
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
  Widget _buildIconButton({
    required Widget child,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        child: child,
        onTap: onPressed,
      ),
    );
  }
}
