import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var apiUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial check
    apiUrl.value = '${dotenv.env['API_URL']}';
  }

  Future<void> _setDatabaseUrl() async {
    // try {
    //   var connectivityResult = await (Connectivity().checkConnectivity());
    //   var networkInfo = NetworkInfo();

    //   if (connectivityResult != ConnectivityResult.none) {
    //     var ipv6Address = await networkInfo.getWifiIPv6();
    //     if (ipv6Address != null && ipv6Address.isNotEmpty) {
    //       apiUrl.value = '${dotenv.env['API_URL']}';  // Ensure 'API_URL' is defined in .env
    //     } else {
    //       apiUrl.value = '${dotenv.env['API_URL']}';  // Ensure 'API_URL' is defined in .env
    //     }
    //   } else {
    //     apiUrl.value = '${dotenv.env['API_URL']}';  // Ensure 'API_URL' is defined in .env
    //   }
    // } catch (e) {
    //   print('Error setting database URL: $e');
    // }
  }
}
