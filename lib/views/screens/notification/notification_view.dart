import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:wallet_blockchain/data/entity/notification_entity.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/viewmodels/notification/notification_view_model.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/container/notification/notification_list_item.dart';
import 'package:wallet_blockchain/views/widgets/back_header_ui.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class NotificationView extends StatefulWidget {
  final String idEntity;

  const NotificationView({Key? key, required this.idEntity}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late NotificationViewModel _notificationViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationViewModel = NotificationViewModel()..onInitView(context);
    _notificationViewModel.getNotificationById(id: widget.idEntity);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _notificationViewModel,
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Selector<NotificationViewModel, ViewState>(
                builder: (_, viewState, __) {
                  if (viewState != ViewState.success) {
                    return Expanded(
                      child: Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: UIColors.colorButton, size: 30),
                      ),
                    );
                  } else {
                    return Expanded(child: _buildBody());
                  }
                },
                selector: (_, viewModel) => viewModel.viewState),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BackHeaderWidget(title: "Notification", onPressed: () {});
  }

  Widget _buildBody() {
    return Selector<NotificationViewModel, List<NotificationEntity>>(
        builder: (_, notification, __) {
          return ListView.builder(
            itemBuilder: (_, index) {
              if (notification == []) {
                return _buildEmpty();
              } else {
                final entity = notification.elementAt(index);
                return NotificationListItemView(entity: entity, onUpdate: () {
                  if (entity.isRead == false) {
                    _notificationViewModel.onClickDone(
                      index: index,
                        entity: entity,
                        idUser: widget.idEntity);
                  }
                });
              }
            },
            itemCount: notification.length,
          );
        },
        selector: (_, viewModel) => viewModel.notification);
  }



  Widget _buildEmpty() {
    return const Center(
      child: UIText("No data....",
          style: TextStyle(fontSize: 16, color: UIColors.black)),
    );
  }
}
