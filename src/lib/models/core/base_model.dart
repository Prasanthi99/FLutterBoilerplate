import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  NetworkState _networkState = NetworkState.Active;
  ViewState get state => _state;
  NetworkState get networkState => _networkState;
  bool isDisposed = false;
  void setState(ViewState viewState) {
    _state = viewState;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

// viewstate.dart
/// Represents the state of the view

enum ViewState { Idle, Busy, LocalFetch }
enum NetworkState { Active, Inactive }
enum ConnectivityStatus { WiFi, Cellular, Offline }
