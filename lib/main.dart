import 'package:betgram_app/Components/Home/HomePage.dart';
import 'package:betgram_app/Components/MatchDetails/MatchInfo.dart';
import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Controllers/MatchInfoController.dart';
import 'package:betgram_app/Controllers/NetworkController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'Controllers/HomeController.dart';
import 'Controllers/SettingsControllers.dart';
import 'Utility/Themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Get.put(NetworkController());
  Get.put(SettingsController());
  Get.put(MatchInfoController());
  Get.put(HomeController());
  Get.put(LiveController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final SettingsController settingController = Get.put(SettingsController());

    return Obx(() => GetMaterialApp(
          transitionDuration: const Duration(milliseconds: 100),
          title: 'Flutter Demo',
          theme: settingController.settings.value.isDarkMode.value
              ? darkappThemeData
              : appThemeData,
          home: const MyHomePage(title: 'BETGRAM'),
        ));
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   return _authController.isLoggedIn.value ? HomePage() : const LoginPage();
    // });
    return HomePage();
  }
}