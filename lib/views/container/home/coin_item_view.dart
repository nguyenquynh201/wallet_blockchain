import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class CoinItemView extends StatelessWidget {
  final DataEntity coin;
  const CoinItemView({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    return SizedBox(
      width: 90,
      height: 90,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CachedNetworkImage(
              imageUrl: ("$coinIconUrl${coin.symbol}.png")
                  .toLowerCase(),
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset(AssetImages.iconLogo),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          UIText(
            coin.symbol,
            style: const TextStyle(
                fontSize: 16, color: UIColors.black),
          ),
          const SizedBox(
            height: 2,
          ),
          UIText(
            "\$${coin.quoteModel.usdEntity.price.toStringAsFixed(2)}",
            style: const TextStyle(
                fontSize: 14, color: UIColors.black),
          ),
        ],
      ),
    );
  }
}

