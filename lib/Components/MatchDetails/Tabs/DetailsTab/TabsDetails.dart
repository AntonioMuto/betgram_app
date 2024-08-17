import 'package:betgram_app/Components/MatchDetails/Tabs/DetailsTab/EventsBox.dart';
import 'package:betgram_app/Utility/CardUtility.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../../Controllers/LiveController.dart';

class TabsDetails extends StatelessWidget {
  const TabsDetails({super.key});
  static final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cardColor = Get.theme.cardColor;
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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 40),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${details?.leagueName ?? ''} ${details?.selectedSeason}, Giornata ${details?.round} ",
                    style: TextFacility.getBoldStyleSubText(12),
                  ),
                ],
              )
            ),
            CardUtility.getCardContainer(
              EventBox()
            )
          ],
        ),
      );
    });
  }
}
