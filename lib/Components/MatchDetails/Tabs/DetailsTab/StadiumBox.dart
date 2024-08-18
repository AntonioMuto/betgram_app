import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controllers/LiveController.dart';
import '../../../../Utility/TextFacility.dart';

class StadiumBox extends StatelessWidget {
  StadiumBox({super.key});
  final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Stadio", style: TextFacility.getBoldStyleText(12)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                _liveController.matchDetails.value.details?.stadium?.name ?? "",
                style: TextFacility.getBoldStyleText(12),
                maxLines: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                _liveController.matchDetails.value.details?.stadium?.city ?? "",
                style: TextFacility.getBoldStyleText(12),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
