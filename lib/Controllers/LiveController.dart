import 'dart:async';
import 'package:betgram_app/Controllers/MatchInfoController.dart';
import 'package:betgram_app/Models/MatchInfo/FixtureInfo.dart';
import 'package:betgram_app/Models/MatchList/MatchList.dart';
import 'package:get/get.dart';
import '../Services/LiveServices/LiveService.dart';

class LiveController extends GetxController {
  var matchesByDay = <MatchList>[].obs;
  var matchDetails = FixtureInfo().obs;  

  var daySelected = DateTime.now().obs;

  //LOADING FLAG
  var loadingMatchList = false.obs;
  var loadingMatchDetails = false.obs;
  var loadingMatchFirstLiveDetails = false.obs;
  
  Timer? _timer;
  Timer? _timerMatchDetails;

  MatchInfoController matchInfoController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // Inizia a recuperare i dati inizialmente
    retrieveLiveMatchList();
    // Configura il Timer per eseguire la funzione ogni 15 secondi
    startTimer();
  }

  @override
  void onClose() {
    // Annulla il Timer quando il controller viene chiuso
    _stopTimer();
    super.onClose();
  }

  Future<void> retrieveLiveMatchList() async {
    try {
      print("updateLive");
      startTimer();
      await retrieveLiveMatchListData();
    } catch (e) {
      // Gestisci eventuali errori qui
      print('Errore durante il recupero dei dati: $e');
    }
  }

  Future<void> retrieveLiveMatchListData() async {
    try {
      matchesByDay.value = await LiveService.retrieveMatchDay();
    } catch (e) {
      // Gestisci eventuali errori qui
      print('Errore durante il recupero dei dati: $e');
    }
  }



  Future<void> retrieveLiveMatchListByDay(DateTime selectedDay) async {
    try {
      print("cancel timer");
      _stopTimer(); // Ferma il timer
      matchesByDay.value = await LiveService.retrieveMatchByDay(selectedDay);
    } catch (e) {
      // Gestisci eventuali errori qui
      print('Errore durante il recupero dei dati: $e');
    }
  }

  void startTimer() {
    // Assicurati che un timer non sia già in esecuzione
    _stopTimer();
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      retrieveLiveMatchList();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null; // Imposta il timer su null per evitare riferimenti successivi
  }

  void startTimerMatchDetails(int id) {
    // Assicurati che un timer non sia già in esecuzione
    stopTimerMatchDetails();
    _stopTimer();
    _timerMatchDetails = Timer.periodic(Duration(seconds: 15), (timer) {
      retrieveMatchDetailsLive(id);
    });
  }

  void stopTimerMatchDetails() {
    _timerMatchDetails?.cancel();
    _timerMatchDetails = null; // Imposta il timer su null per evitare riferimenti successivi
  }

  Future<void> setMatchDetails(int id) async {
    _stopTimer();
    await retrieveMatchDetails(id);
    matchInfoController.matchId.value = id;
  }

  Future<void> retrieveMatchDetails(int id) async {
    matchDetails.value = await LiveService.retrieveMatchDetails(id);
  }

  Future<void> retrieveMatchDetailsLive(int id) async {
    matchDetails.value = await LiveService.retrieveLiveMatchDetails(id);
  }

  void setLoadingLiveFirstMatch(bool value) {
    loadingMatchFirstLiveDetails.value = value;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }


}
