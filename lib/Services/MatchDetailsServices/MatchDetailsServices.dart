import 'dart:convert';

import 'package:betgram_app/Controllers/MatchInfoController.dart';
import 'package:betgram_app/Models/MatchInfo/Statistics/StatsDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:betgram_app/Controllers/NetworkController.dart';
import 'package:http/http.dart' as http;

import '../../Controllers/LiveController.dart';

class matchDetailsServices {
  static final NetworkController _networkController = Get.find();
  static final LiveController _liveController = Get.find();
  static final MatchInfoController _matchInfoController = Get.find();

  static Future<StatsDetails> retrieveMatchStats(int id) async {
    _matchInfoController.loadingStats.value = true;
    try {
      http.Response response = await http.get(
          Uri.parse('${_networkController.apiUrl}/matches/retrieve/$id/stats'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${dotenv.env['TOKEN']}'
          });
      if (response.statusCode == 200){
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        StatsDetails fixtureStats = StatsDetails.fromMap(jsonMap);
        _matchInfoController.loadingStats.value = false;
        return fixtureStats;
      } else {
        _matchInfoController.loadingStats.value = false;
        Get.snackbar("ERROR ${response.statusCode}", "errore nel recupero dei dati", animationDuration: const Duration(seconds: 3), icon: const Icon(Icons.error_outline, color: Colors.white),backgroundColor: const Color.fromARGB(255, 226, 86, 76) );
        return StatsDetails();
      }
    } catch (e) {
      _matchInfoController.loadingStats.value = false;
      return StatsDetails();
    }
  }
}
