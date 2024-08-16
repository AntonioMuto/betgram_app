import 'dart:convert';

import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Controllers/NetworkController.dart';
import 'package:betgram_app/Models/MatchInfo/FixtureInfo.dart';
import 'package:betgram_app/Models/MatchList/MatchList.dart';
import 'package:betgram_app/Utility/Costants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LiveService {
  static final NetworkController _networkController = Get.find();
  static final LiveController _liveController = Get.find();

  static Future<List<MatchList>> retrieveMatchDay() async {
    try {
      http.Response response = await http.get(
          Uri.parse('${_networkController.apiUrl}/live/retrieve'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${dotenv.env['TOKEN']}'
          });
      if (response.statusCode == 200){
        List<dynamic> jsonArray = jsonDecode(utf8.decode(response.bodyBytes));
        List<MatchList> matchList = [];
        for (var element in jsonArray) {
          MatchList match = MatchList.fromMap(element);
          matchList.add(match);
        }
        return matchList;
      } else {
        Get.snackbar("ERROR ${response.statusCode}", "errore nel recupero dei dati", animationDuration: const Duration(seconds: 3), icon: const Icon(Icons.error_outline, color: Colors.white),backgroundColor: const Color.fromARGB(255, 226, 86, 76) );
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<MatchList>> retrieveMatchByDay(DateTime selectedDay) async {
    try {
      _liveController.loadingMatchList.value = true;
      http.Response response = await http.get(
          Uri.parse('${_networkController.apiUrl}/matches/retrieveByDate/${selectedDay.year}${selectedDay.month < 10 ? '0${selectedDay.month}' : selectedDay.month}${selectedDay.day < 10 ? '0${selectedDay.day}' : selectedDay.day}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${dotenv.env['TOKEN']}'
          });
      if (response.statusCode == 200){
        List<dynamic> jsonArray = jsonDecode(utf8.decode(response.bodyBytes));
        List<MatchList> matchList = [];
        for (var element in jsonArray) {
          MatchList match = MatchList.fromMap(element);
          matchList.add(match);
        }
        _liveController.loadingMatchList.value = false;
        return matchList;
      } else {
        _liveController.loadingMatchList.value = false;
        Get.snackbar("ERROR ${response.statusCode}", "errore nel recupero dei dati", animationDuration: const Duration(seconds: 3), icon: const Icon(Icons.error_outline, color: Colors.white),backgroundColor: const Color.fromARGB(255, 226, 86, 76) );
        return [];
      }
    } catch (e) {
      _liveController.loadingMatchList.value = false;
      return [];
    }
  }

  static Future<FixtureInfo> retrieveMatchDetails(int id) async {
    _liveController.loadingMatchDetails.value = true;
    try {
      http.Response response = await http.get(
          Uri.parse('${_networkController.apiUrl}/matches/retrieve/${id}/info'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${dotenv.env['TOKEN']}'
          });
      if (response.statusCode == 200){
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        FixtureInfo fixtureInfo = FixtureInfo.fromMap(jsonMap);
        _liveController.loadingMatchDetails.value = false;
        return fixtureInfo;
      } else {
        _liveController.loadingMatchDetails.value = false;
        Get.snackbar("ERROR ${response.statusCode}", "errore nel recupero dei dati", animationDuration: const Duration(seconds: 3), icon: const Icon(Icons.error_outline, color: Colors.white),backgroundColor: const Color.fromARGB(255, 226, 86, 76) );
        return FixtureInfo();
      }
    } catch (e) {
      _liveController.loadingMatchDetails.value = false;
      return FixtureInfo();
    }
  }

}