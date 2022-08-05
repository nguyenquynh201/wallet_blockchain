import 'package:flutter/material.dart';
import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/container/home/coin_chart_item_view.dart';
import 'package:wallet_blockchain/views/container/home/coin_item_view.dart';

class CoinListItemView extends StatefulWidget {
  final DataEntity coin;

  const CoinListItemView({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinListItemView> createState() => _CoinListItemViewState();
}

class _CoinListItemViewState extends State<CoinListItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: UIColors.divided),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CoinItemView(coin: widget.coin),
          ChartItemView(
            coin: widget.coin,
          )
        ],
      ),
    );
  }
}
