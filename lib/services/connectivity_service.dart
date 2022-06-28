import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rent_home/services/utils.dart';

class ConnectivityService {
  static Future<void> isConnectInternet(ConnectivityResult con, context) async {
    if (con == ConnectivityResult.none) {
       await Utils.noInternetConnectionDialog(context);
    }
  }
}
