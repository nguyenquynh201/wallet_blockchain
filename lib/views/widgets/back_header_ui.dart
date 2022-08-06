import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class BackHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isHide;
  const BackHeaderWidget({
    Key? key,
    required this.title,
    required this.onPressed,  this.isHide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: UIColors.colorBackground),
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              child: _buildBackIcon(context),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: _buildTitle(),
            ),
            isHide == true ?
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: _buildIconButton(
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AssetImages.iconLogout,
                      fit: BoxFit.contain,
                      color: UIColors.divided,
                    ),
                  ),
                  onPressed: onPressed),
            ) : const Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return FittedBox(
      child: UIText(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: UIColors.divided,
        ),
      ),
    );
  }

  Widget _buildBackIcon(BuildContext context) {
    return _buildIconButton(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AssetImages.iconBack,
          fit: BoxFit.contain,
          color: UIColors.divided,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
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
