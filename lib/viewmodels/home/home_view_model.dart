import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet_blockchain/data/entity/user_entiy.dart';
import 'package:wallet_blockchain/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
  }
  UserEntity? _userEntity;
  UserEntity? get userEntity => _userEntity;
  void handleUser() {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserEntity>(
      fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
  final user =  moviesRef.get();
 
  }
  Future<UserEntity> getUser(UserEntity entity) async{
    _userEntity = entity;
    return entity;
  }
}
