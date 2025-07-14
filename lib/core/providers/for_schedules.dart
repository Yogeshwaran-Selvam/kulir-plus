import 'package:flutter/material.dart';

import '/core/core.dart';

class ScheduleProvider with ChangeNotifier {
  final List<ScheduleModel> _schedules = [
    ScheduleModel(
      id: 0,
      title: "Early Workout",
      weekdays: [1, 3, 5], // Mon, Wed, Fri
      startTime: const TimeOfDay(hour: 6, minute: 0),
      endTime: const TimeOfDay(hour: 7, minute: 30),
      acs: [1],
      temperature: 21,
      mode: "Cool",
      fanSpeed: "High",
      color: colors[4],
      isRecurring: true,
    ),
    ScheduleModel(
      id: 1,
      title: "Early Morning Chill",
      dates: [DateTime(2025, 7, 1, 5, 0), DateTime(2025, 7, 5, 6, 30)],
      startTime: const TimeOfDay(hour: 5, minute: 0),
      endTime: const TimeOfDay(hour: 6, minute: 30),
      acs: [1],
      temperature: 21,
      mode: "Cool",
      fanSpeed: "Low",
      color: colors[0],
      isRecurring: false,
    ),
    ScheduleModel(
      id: 2,
      title: "Morning Refresh",
      dates: [DateTime(2025, 7, 2, 7, 0), DateTime(2025, 7, 2, 9, 0)],
      startTime: const TimeOfDay(hour: 7, minute: 0),
      endTime: const TimeOfDay(hour: 9, minute: 0),
      acs: [1, 2],
      temperature: 22,
      mode: "Eco",
      fanSpeed: "Medium",
      color: colors[1],
      isRecurring: false,
    ),
    ScheduleModel(
      id: 3,
      title: "Mid-Morning Save",
      weekdays: [1, 2, 3, 4, 5], // Weekdays only (Mon-Fri)
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 11, minute: 30),
      acs: [2],
      temperature: 25,
      mode: "Eco",
      fanSpeed: "Auto",
      color: colors[2],
      isRecurring: true,
    ),
    ScheduleModel(
      id: 4,
      title: "Noon Comfort",
      dates: [DateTime(2025, 7, 3, 12, 0), DateTime(2025, 7, 5, 14, 0)],
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 14, minute: 0),
      acs: [1, 3],
      temperature: 23,
      mode: "Cool",
      fanSpeed: "Medium",
      color: colors[3],
      isRecurring: false,
    ),
    ScheduleModel(
      id: 5,
      title: "Afternoon Relax",
      weekdays: [0, 6],
      startTime: const TimeOfDay(hour: 15, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
      acs: [3],
      temperature: 24,
      mode: "Eco",
      fanSpeed: "Auto",
      color: colors[4],
      isRecurring: true,
    ),
  ];

  List<ScheduleModel> get schedules => _schedules;

  ScheduleModel getById(int id) {
    try {
      return _schedules.firstWhere((schedule) => schedule.id == id);
    } catch (e) {
      return ScheduleModel(
        title: 'New Schedule',
        startTime: TimeOfDay.now(),
        endTime: TimeOfDay.now(),
        acs: [1],
        temperature: 21,
        mode: "Cool",
        fanSpeed: "Low",
        color: Colors.blue,
        isRecurring: false,
      );
    }
  }

  void addSchedule(ScheduleModel newSchedule) {
    newSchedule.id = _schedules.length;
    _schedules.add(newSchedule);
    notifyListeners();
  }

  void updateSchedule(ScheduleModel updatedSchedule) {
    final index = _schedules.indexWhere((s) => s.id == updatedSchedule.id);
    if (index != -1) {
      _schedules[index] = updatedSchedule;
      notifyListeners();
    }
  }

  void removeSchedule(int scheduleId) {
    _schedules.removeWhere((schedule) => schedule.id == scheduleId);
    notifyListeners();
  }

  List<ScheduleModel> getSchedulesForDay(DateTime date) {
    return _schedules.where((schedule) {
      if (schedule.isRecurring) {
        return schedule.weekdays.contains(date.weekday % 7);
      } else {
        return _isDateInRange(date, schedule.dates[0], schedule.dates[1]);
      }
    }).toList();
  }
  
  bool _isDateInRange(DateTime date, DateTime start, DateTime end) {
    return (date.isAfter(start) || date.isAtSameMomentAs(start)) &&
           (date.isBefore(end) || date.isAtSameMomentAs(end));
  }

  List<Color> getDotColorsForDate(DateTime date) {
    return getSchedulesForDay(date).map((s) => s.color).toList();
  }

  List<ScheduleModel> getSchedulesForAC(int acId) {
    return _schedules.where((schedule) => schedule.acs.contains(acId)).toList();
  }
}