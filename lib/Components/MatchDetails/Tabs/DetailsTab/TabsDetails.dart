import 'package:betgram_app/Components/MatchDetails/Tabs/DetailsTab/EventsBox.dart';
import 'package:betgram_app/Components/MatchDetails/Tabs/DetailsTab/RefereeBox.dart';
import 'package:betgram_app/Components/MatchDetails/Tabs/DetailsTab/StadiumBox.dart';
import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:betgram_app/Models/MatchInfo/Header/HeaderInfoTeam.dart';
import 'package:betgram_app/Utility/CardUtility.dart';
import 'package:betgram_app/Utility/Costants.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../../Controllers/LiveController.dart';
import 'TeamFormDetails.dart';

class TabsDetails extends StatelessWidget {
  const TabsDetails({super.key});
  static final LiveController _liveController = Get.find();
  static final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var cardColor = _settingsController.theme.value.cardColor;
      var details = _liveController.matchDetails.value.details;
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.primaryColorDark.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // Offset della ombra
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "${dotenv.env['IMAGE_FLAG_URL']}dark/${details?.leagueId}.png",
                      width: 25,
                      height: 25,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, size: 40),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${details?.leagueName ?? ''} ${details?.selectedSeason}, Giornata ${details?.round} ",
                      style: TextStyle(
                          color:
                              _settingsController.theme.value.primaryColorDark,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          decoration: TextDecoration.none),
                    ),
                  ],
                )),
            if(_liveController.matchDetails.value.details?.events?.isNotEmpty ?? false)
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.primaryColorDark.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // Offset della ombra
                    ),
                  ],
                ),
                child: EventBox()),
            SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(_liveController.matchDetails.value.details?.stadium?.name != null)
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      width: Get.width - 200,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColorDark.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2), // Offset della ombra
                          ),
                        ],
                      ),
                      child: (StadiumBox())),
                  const SizedBox(width: 8),
                  if(_liveController.matchDetails.value.details?.referee?.name != null)
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      width: Get.width * 0.40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColorDark.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2), // Offset della ombra
                          ),
                        ],
                      ),
                      child: (RefereeBox())),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            if(_liveController.matchDetails.value.details?.teamForm?.fixtureHome != null )
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.primaryColorDark.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // Offset della ombra
                    ),
                  ],
                ),
                child: (TeamFormDetails(
                    team: _liveController.matchDetails.value.header?.teams[0] ??
                        HeaderInfoTeam(
                            name: "",
                            id: -1,
                            score: 0,
                            imageUrl: Costants.URL_NA_IMAGE), isHome: true))),
            if(_liveController.matchDetails.value.details?.teamForm?.fixtureAway != null )
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.primaryColorDark.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // Offset della ombra
                    ),
                  ],
                ),
                child: (TeamFormDetails(
                    team: _liveController.matchDetails.value.header?.teams[1] ??
                        HeaderInfoTeam(
                            name: "",
                            id: -1,
                            score: 0,
                            imageUrl: Costants.URL_NA_IMAGE), isHome: false))),
          ],
        ),
      );
    });
  }
}
