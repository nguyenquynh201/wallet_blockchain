import 'package:flutter/material.dart';
import 'package:wallet_blockchain/enum/view_state_enum.dart';

abstract class BaseViewModel with ChangeNotifier {

  static List<ChangeNotifier> _notifierList = [];

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  late BuildContext _context;

  BuildContext get context => _context;

  void onInitView(BuildContext context) {
    _context = context;
  }

  void setState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }

  ///
  void onBuildCompleted() {
    if(!_notifierList.contains(this)) {
      _notifierList.add(this);
    }
  }

  void removeChangeNotifier() {
    if(_notifierList.contains(this)) {
      _notifierList.remove(this);
    }
  }

  @override
  void dispose() {
    removeChangeNotifier();
    super.dispose();
  }
}