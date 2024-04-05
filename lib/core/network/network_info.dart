import 'package:connectivity_plus/connectivity_plus.dart';

abstract class Connection {
  Future<bool> isConnected();
}

class InternetChecker implements Connection {
  @override
  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
