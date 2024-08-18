import 'package:betgram_app/Utility/Costants.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../../Controllers/LiveController.dart';

class RefereeBox extends StatelessWidget {
  RefereeBox({super.key});
  final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Arbitro", style: TextFacility.getBoldStyleText(12)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                _liveController.matchDetails.value.details?.referee?.name ?? "",
                style: TextFacility.getBoldStyleText(12),
                maxLines: 2,
              ),
            ),
            CachedNetworkImage(
              imageUrl: _liveController
                      .matchDetails.value.details?.referee?.imageUrl ??
                  Costants.URL_NA_IMAGE,
              width: 20,
              height: 20,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.sports_soccer),
            ),
          ],
        )
      ],
    );
  }
}
