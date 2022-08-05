import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_blockchain/data/entity/chart_entity.dart';
import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class ChartItemView extends StatelessWidget {
  final DataEntity coin;

  const ChartItemView({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChartEntity> chart = [
      ChartEntity(coin.quoteModel.usdEntity.percentChange_90d, 2160),
      ChartEntity(coin.quoteModel.usdEntity.percentChange_60d, 1440),
      ChartEntity(coin.quoteModel.usdEntity.percentChange_30d, 720),
      ChartEntity(coin.quoteModel.usdEntity.percentChange_7d, 168),
      ChartEntity(coin.quoteModel.usdEntity.percentChange_24h, 24),
      ChartEntity(coin.quoteModel.usdEntity.percentChange_1h, 1),
    ];
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.only(left: 16.0),
                height: 100,
                width: double.infinity,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: CategoryAxis(isVisible: false),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<ChartEntity, String>>[
                    LineSeries<ChartEntity, String>(
                        dataSource: chart,
                        xValueMapper: (ChartEntity data, _) =>
                            data.year.toString(),
                        yValueMapper: (ChartEntity data, _) => data.value)
                  ],
                )),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(right: 16),
            width: 75,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: coin.quoteModel.usdEntity.percentChange_7d >= 0
                    ? Colors.green
                    : UIColors.errorMessage),
            child: Center(
              child: UIText(
                "${coin.quoteModel.usdEntity.percentChange_7d.toStringAsFixed(2)}%",
                style: const TextStyle(fontSize: 16, color: UIColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
