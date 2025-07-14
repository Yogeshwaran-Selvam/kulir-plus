import 'package:flutter/material.dart';

class ScheduleModel {
  int id;
  String title;
  List<DateTime> dates;
  List<int> weekdays;
  TimeOfDay startTime;
  TimeOfDay endTime;
  List<int> acs;
  int temperature;
  String mode;
  String fanSpeed;
  Color color;
  bool isRecurring;

  ScheduleModel({
    this.id = -1,
    required this.title,
    this.dates = const [],
    this.weekdays = const [],
    required this.startTime,
    required this.endTime,
    required this.acs,
    required this.temperature,
    required this.mode,
    required this.fanSpeed,
    required this.color,
    this.isRecurring = false,
  });
}