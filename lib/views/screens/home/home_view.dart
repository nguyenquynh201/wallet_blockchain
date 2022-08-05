import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_blockchain/data/entity/chart_entity.dart';
import 'package:wallet_blockchain/data/entity/data_entity.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';
import 'package:wallet_blockchain/viewmodels/home/home_view_model.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/container/home/coin_list_item_view.dart';
import 'package:wallet_blockchain/views/widgets/ui_header.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseFirestore.instance.collection('users');
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeViewModel = HomeViewModel()..onInitView(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _homeViewModel,
      child: FutureBuilder<DocumentSnapshot>(
          future: user.doc(id).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const UIText("Something went wrong");
            }
            if (snapshot.hasData && !snapshot.data!.exists) {
              return const UIText("Document does not exists");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              UserEntity data = UserEntity.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);

              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      _buildHeader(entity: data),
                      Selector<HomeViewModel, ViewState>(
                          builder: (_, viewState, __) {
                            if (viewState != ViewState.success) {
                              return Expanded(
                                child: Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                          color: UIColors.colorButton,
                                          size: 30),
                                ),
                              );
                            } else {
                              return Expanded(child: _buildBody());
                            }
                          },
                          selector: (_, viewModel) => viewModel.viewState)
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: UIColors.colorButton, size: 30),
            );
          }),
    );
  }

  Widget _buildHeader({required UserEntity entity}) {
    return HomeHeader(entity: entity);
  }

  Widget _buildBody() {
    return Selector<HomeViewModel, List<DataEntity>>(
        builder: (_, data, __) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              if (data.isEmpty) {
                return _buildEmpty();
              } else {
                final coin = data.elementAt(index);

                return CoinListItemView(coin: coin);
              }
            },
            itemCount: data.length,
          );
        },
        selector: (_, viewModel) => viewModel.coin);
  }

  Widget _buildEmpty() {
    return const Center(
      child: UIText("No data....",
          style: TextStyle(fontSize: 16, color: UIColors.black)),
    );
  }

  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();
    _homeViewModel.onInitView(context);
  }
}
