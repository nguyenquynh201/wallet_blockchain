import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/utils/string_utils.dart';
import 'package:wallet_blockchain/viewmodels/profile/profile_view_model.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/back_header_ui.dart';
import 'package:wallet_blockchain/views/widgets/ui_button.dart';
import 'package:wallet_blockchain/views/widgets/ui_input.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class ProfileView extends StatefulWidget {
  final UserEntity entity;

  const ProfileView({Key? key, required this.entity}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel _profileViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileViewModel = ProfileViewModel()..onInitView(context);
    _profileViewModel.getUserList(entity: widget.entity);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _profileViewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Selector<ProfileViewModel, ViewState>(
                  builder: (_, viewState, __) {
                    if (viewState != ViewState.success) {
                      return Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: UIColors.colorButton, size: 30),
                      );
                    } else {
                      return _buildBody();
                    }
                  },
                  selector: (_, viewModel) => viewModel.viewState)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BackHeaderWidget(
      isHide: true,
      title: widget.entity.name!,
      onPressed: () {
        FirebaseAuth.instance.signOut();
        _profileViewModel.navigationToSignInView(context: context);
      },
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          _buildCoinForYou(),
          _buildSizeBox(height: 20),
          _buildReceiver(),
          _buildSizeBox(height: 10),
          _buildCoinSend(),
          _buildWalletCoin(),
          _buildSizeBox(height: 10),
          Selector<ProfileViewModel, double>(
              builder: (_, total, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildTitle(title: "Coin send :"),
                    _buildTitle(
                        title: "${total.toInt()}",
                        isColor: UIColors.errorMessage),
                  ],
                );
              },
              selector: (_, viewModel) => viewModel.totalCoin),
          _buildSizeBox(height: 50),
          Selector<ProfileViewModel, bool>(
              builder: (_, enable, __) {
                return UIButton(
                  padding: const EdgeInsets.only(bottom: 18),
                  enabled: enable,
                  onPressed: () {
                    _profileViewModel.sendCoinToUser();
                  },
                  title: "Send coin",
                  titleStyle: const TextStyle(
                      color: UIColors.white, fontWeight: FontWeight.w700),
                );
              },
              selector: (_, viewModel) => viewModel.isEnable),
          _buildSizeBox(height: 10),
          Selector<ProfileViewModel, bool>(
              builder: (_, enable, __) {
                return UIButton(
                  padding: const EdgeInsets.only(bottom: 18),
                  enabled: enable,
                  onPressed: () {
                    _profileViewModel.sendCoinAll();
                  },
                  title: "Send all coin",
                  titleStyle: const TextStyle(
                      color: UIColors.white, fontWeight: FontWeight.w700),
                );
              },
              selector: (_, viewModel) => viewModel.isEnableAll)
        ],
      ),
    );
  }

  Widget _buildCoinForYou() {
    return Selector<ProfileViewModel, UserEntity>(
        builder: (_, entity, __) {
          if (entity != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildTitle(title: "Coin for you :"),
                _buildTitle(
                    title: "${entity.coin!.toInt()}",
                    isColor: UIColors.errorMessage),
              ],
            );
          } else {
            return Container();
          }
        },
        selector: (_, viewModel) => viewModel.entity!);
  }

  Widget _buildReceiver() {
    return Selector<ProfileViewModel, List<UserEntity>>(
        builder: (_, userEntity, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: "Receiver"),
              _buildSizeBox(height: 10),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: UIColors.colorBackground, width: 2)),
                    hintText: "Please , choose name to send",
                  ),
                  items: userEntity
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          onTap: () {
                            _profileViewModel.onChangUserId(e.id!);
                          },
                          child: UIText(e.name!),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {}),
            ],
          );
        },
        selector: (_, viewModel) => viewModel.user);
  }

  Widget _buildCoinSend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title: "Coin for you :"),
        _buildSizeBox(height: 10),
        Selector<ProfileViewModel, ValidateCoinState>(
            builder: (_, coinState, __) {
              return UITextInput(
                isSize: true,
                hint: "0.1coin.....",
                onChanged: _profileViewModel.onChangCoin,
                errorMessage:
                    StringUtils.toInvalidCoinString(coinState, context),
                onFocus: _profileViewModel.onFocusCoin,
                keyboardType: TextInputType.number,
              );
            },
            selector: (_, viewModel) => viewModel.validateCoinState),
      ],
    );
  }

  _buildWalletCoin() {
    return Selector<ProfileViewModel, List<String>>(
        builder: (_, walletCoin, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: "Wallet Coin"),
              _buildSizeBox(height: 10),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: UIColors.colorBackground, width: 2)),
                    hintText: "Please , choose name coin",
                  ),
                  items: walletCoin
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          onTap: () {
                            _profileViewModel.onChangWalletCoin(e);
                          },
                          child: UIText(e.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {}),
            ],
          );
        },
        selector: (_, viewModel) => viewModel.walletCoin);
  }

  Widget _buildTitle({required String title, Color? isColor}) {
    return UIText(
      title,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isColor ?? UIColors.black),
    );
  }

  Widget _buildSizeBox({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
