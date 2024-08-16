import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/HomeController.dart';
import '../../Controllers/LiveController.dart';
import '../../Controllers/SettingsControllers.dart';
import '../../Utility/TextFacility.dart';
import '../MatchList/CalendarDialog.dart';
import '../MatchList/ListFixtures.dart';
import 'package:betgram_app/Components/Home/Home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SettingsController settingController = Get.find();
  final HomeController homeController = Get.find();
  final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          size: 30,
          color: Get.theme.primaryColorDark,
        ),
        title: Text(
          "Betgram",
          style: TextFacility.getBoldStyleText(20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Obx(() => homeController.selectedIndex.value != 2
                    ? IconButton(
                        onPressed: () async {
                          // await _liveController.retrieveLiveMatchList();
                          Get.snackbar("ERROR ", "errore nel recupero dei dati",
                              animationDuration: const Duration(seconds: 4),
                              icon: const Icon(Icons.error_outline,
                                  color: Colors.white),
                              backgroundColor: Color.fromARGB(180, 226, 86, 76),
                              isDismissible: true,
                              dismissDirection: DismissDirection.up,
                              shouldIconPulse: true,
                              
                              mainButton: TextButton(
                                  onPressed: Get.back,
                                  child: const Icon(Icons.close)));
                        },
                        icon: Icon(
                          Icons.notifications_none_sharp,
                          size: 30,
                          color: Get.theme.primaryColorDark,
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          Get.defaultDialog(
                            backgroundColor: Get.theme.cardColor,
                            title: "",
                            content: CalendarDialog(),
                          );
                        },
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          size: 30,
                          color: Get.theme.primaryColorDark,
                        ))),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800]),
                    onPressed: () {
                      settingController.toggleDarkMode();
                    },
                    child: Obx(() => Text(
                        settingController.settings.value.isDarkMode.value
                            ? "Dark Mode"
                            : "Light Mode")),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Obx(
        () => homeController.selectedIndex.value != -1
            ? Builder(builder: (context) {
                switch (homeController.selectedIndex.value) {
                  case 0:
                    return Home();
                  case 1:
                    return Text("CIAO1");
                  case 2:
                    return ListFixtures(); // Wrap with Expanded
                  case 3:
                    return Text("CIAO3");
                  default:
                    return Placeholder();
                }
              })
            : Placeholder(),
      ),
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(40, 20),
                    topRight: Radius.elliptical(40, 20)),
                color: Get.theme.cardColor),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.stadium),
                  label: 'Campionati',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_soccer),
                  label: 'Partite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_sharp),
                  label: 'Mie Scommesse',
                ),
              ],
              currentIndex: homeController.selectedIndex.value,
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              showUnselectedLabels: false,
              unselectedItemColor: Color.fromARGB(255, 106, 106, 106),
              onTap: homeController.changeIndex,
              unselectedIconTheme: IconThemeData(size: 25),
            ),
          )),
    );
  }
}
