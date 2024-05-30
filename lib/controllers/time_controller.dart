import 'package:fgo_app/models/time_conversion.dart';
import 'package:fgo_app/services/time_service.dart';
import 'package:flutter/material.dart';

class TimeConversionController {
  ValueNotifier<TimeConversion> timeConversionModel =
      ValueNotifier(TimeConversion(
    inputTime: DateTime.now(),
    inputTimeZone: 'WIB',
    outputTimeZone: 'WIB',
  ));

  DateTime get inputTime => timeConversionModel.value.inputTime;
  String get inputTimeZone => timeConversionModel.value.inputTimeZone;
  String get outputTimeZone => timeConversionModel.value.outputTimeZone;
  DateTime get convertedTime => _getConvertedTime();
  String get formattedConvertedTime => _getFormattedConvertedTime();
  String get formattedInputTime => _getFormattedInputTime();

  void updateInputTime(DateTime time) {
    timeConversionModel.value = TimeConversion(
      inputTime: time,
      inputTimeZone: timeConversionModel.value.inputTimeZone,
      outputTimeZone: timeConversionModel.value.outputTimeZone,
    );
  }

  void updateInputTimeZone(String timeZone) {
    timeConversionModel.value = TimeConversion(
      inputTime: timeConversionModel.value.inputTime,
      inputTimeZone: timeZone,
      outputTimeZone: timeConversionModel.value.outputTimeZone,
    );
  }

  void updateOutputTimeZone(String timeZone) {
    timeConversionModel.value = TimeConversion(
      inputTime: timeConversionModel.value.inputTime,
      inputTimeZone: timeConversionModel.value.inputTimeZone,
      outputTimeZone: timeZone,
    );
  }

  void swapTimeZones() {
    timeConversionModel.value = TimeConversion(
      inputTime: timeConversionModel.value.inputTime,
      inputTimeZone: timeConversionModel.value.outputTimeZone,
      outputTimeZone: timeConversionModel.value.inputTimeZone,
    );
  }

  DateTime _getConvertedTime() {
    return TimeConversionService.convertTime(
      timeConversionModel.value.inputTime,
      timeConversionModel.value.inputTimeZone,
      timeConversionModel.value.outputTimeZone,
    );
  }

  String _getFormattedConvertedTime() {
    return TimeConversionService.formatTime(_getConvertedTime());
  }

  String _getFormattedInputTime() {
    return TimeConversionService.formatTime(inputTime);
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(timeConversionModel.value.inputTime),
    );
    if (picked != null) {
      updateInputTime(DateTime(
        timeConversionModel.value.inputTime.year,
        timeConversionModel.value.inputTime.month,
        timeConversionModel.value.inputTime.day,
        picked.hour,
        picked.minute,
      ));
    }
  }
}
