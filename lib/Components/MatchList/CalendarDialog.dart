import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Controllers/SettingsControllers.dart';

class CalendarDialog extends StatelessWidget {
  CalendarDialog({super.key});
  final LiveController _liveController = Get.find();
  final SettingsController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width - 10,
        height: 400,
        child: Obx(() {
          final cardColor = settingController.settings.value.isDarkMode.value == true ? const Color.fromARGB(255, 78, 78, 78) : Colors.white;
          return TableCalendar(
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 78, 78))),
            calendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Get.theme.primaryColorDark),
                todayTextStyle: TextStyle(color: Get.theme.primaryColorDark),
                selectedTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                    color: Colors.transparent),
                todayDecoration: BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                outsideDaysVisible: false,
                weekendTextStyle:
                    TextStyle(color: Color.fromARGB(255, 141, 141, 141))),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _liveController.daySelected.value,
            currentDay: _liveController.daySelected.value,
            onDaySelected: (newSelectedDay, newFocusedDay) async {
              _liveController.daySelected.value = newSelectedDay;
              if(isSameDay(DateTime.now(), newSelectedDay)){
                _liveController.retrieveLiveMatchList();
              } else{
                _liveController.retrieveLiveMatchListByDay(newSelectedDay);
              }
              Get.back();
            },
          );
        }));
  }
}
