import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  List<DateTime> monthDays({bool stopAtThisDay = false}) {
    final firstDay = DateUtils.dateOnly(this).copyWith(day: 1);
    final totalDays = DateUtils.getDaysInMonth(year, month);
    final lastDay = stopAtThisDay ? this : firstDay.copyWith(day: totalDays);
    final List<DateTime> days = [];
    for (int i = 0; i < totalDays; i++) {
      final current = firstDay.copyWith(day: firstDay.day + i);
      if (current.isAfter(lastDay)) break;
      days.add(current);
    }
    return days;
  }
}
