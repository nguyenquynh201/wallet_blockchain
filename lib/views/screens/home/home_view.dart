import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_header.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>  with RouteAware{
  final id = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: user.doc(id).get(), builder: (BuildContext context,
        AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          body:  Center(
            child: Column(
              children: [
                _buildHeader(entity: data),
              ],
            ),
          ),
        );
      }
      return Center(
        child: LoadingAnimationWidget.threeArchedCircle(
            color: UIColors.colorButton, size: 30),
      );
    });
  }

  Widget _buildHeader({required UserEntity entity}) {
    return HomeHeader(entity: entity);
  }
  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();

  }
}
