import 'package:betgram_app/Components/MatchList/CustomMatchTile.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/LiveController.dart';
import '../../Models/MatchList/ShortInfoFixture.dart';

class ListFixtures extends StatelessWidget {
  const ListFixtures({super.key});
  static final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var matchLists = _liveController.matchesByDay;
      return _liveController.loadingMatchList.value == false ?
       matchLists.isEmpty ? Center(child: Text("Nessun risultato", style: TextFacility.getBoldStyleText(20))) :
       ListView.builder(
        itemCount: matchLists.length,
        itemBuilder: (context, index) {
          final matchList = matchLists[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Get.theme.primaryColorDark.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4), // Offset della ombra
                ),
              ],
            ),
            child: ExpansionTile(
              collapsedIconColor: Get.theme.primaryColorDark,
              iconColor: Get.theme.primaryColorDark,
              expansionAnimationStyle: AnimationStyle(duration: 0.5.seconds),
              tilePadding: EdgeInsets.symmetric(
                  horizontal: 13), // Aggiungi padding per il titolo e il lead
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              leading: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Arrotonda l'immagine del logo
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/${matchList.primaryId}.png",
                    width: 25,
                    height: 25,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 40),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width - 155,
                    child: Text(
                      matchList.name,
                      style: TextFacility.getBoldStyleText(14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (matchList.matches.firstWhereOrNull((element) => element.status?.ongoing == true) != null) // Condizione per mostrare il pallino rosso
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              children: matchList.matches.map((match) {
                return Container(
                  child: CustomMatchTile(match: match),
                );
              }).toList(),
            ),
          );
        },
      )
      : Center(child: CircularProgressIndicator(color: Get.theme.primaryColorDark,));
    });
  }
}
