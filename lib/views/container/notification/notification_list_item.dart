import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_blockchain/data/entity/notification_entity.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';
class NotificationListItemView extends StatelessWidget {
  final NotificationEntity entity;
  final VoidCallback onUpdate;
  const NotificationListItemView({Key? key, required this.entity, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: UIColors.divided,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _buildThumbnail(),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIText(
                            "${entity.title}",
                            style: const TextStyle(
                                fontSize: 16, color: UIColors.black),
                          ),
                          UIText(
                            "Number coin : ${entity.numberCoin!.toInt()}",
                            style: TextStyle(
                                fontSize: 14,
                                color: UIColors.errorMessage,
                                fontWeight: FontWeight.w400),
                          ),
                          UIText(
                            "Date send :${DateFormat('dd-MM-yyyy').format(entity.createdAt!)}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: UIColors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: onUpdate,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.only(right: 16),
                          width: 80,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: entity.isRead == false
                                  ? Colors.green
                                  : Colors.black12),
                          child: Center(
                            child: UIText(
                              entity.isRead == false
                                  ? "Nhận"
                                  : "Đã nhận",
                              style: const TextStyle(
                                  fontSize: 12, color: UIColors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
  Widget _buildThumbnail() {
    return InkWell(
      onTap: () {},
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
}
