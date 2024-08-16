import 'dart:async';
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
  
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Inizia a recuperare i dati inizialmente
    retrieveLiveMatchList();
    // Configura il Timer per eseguire la funzione ogni 15 secondi
    _startTimer();
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
      _startTimer();
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

  void _startTimer() {
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

  Future<void> setMatchDetails(int id) async {
    matchDetails.value = await LiveService.retrieveMatchDetails(id);
  }


}
