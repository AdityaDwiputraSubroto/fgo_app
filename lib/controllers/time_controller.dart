import 'package:fgo_app/models/time_conversion.dart';
import 'package:fgo_app/services/time_service.dart';
import 'package:flutter/material.dart';

class TimeConversionController extends ChangeNotifier {
  TimeConversion _timeConversionModel = TimeConversion(
    inputTime: DateTime.now(),
    inputTimeZone: 'WIB',
    outputTimeZone: 'WIB',
  );

  DateTime get inputTime => _timeConversionModel.inputTime;
  String get inputTimeZone => _timeConversionModel.inputTimeZone;
  String get outputTimeZone => _timeConversionModel.outputTimeZone;
  DateTime get convertedTime => _getConvertedTime();
  String get formattedConvertedTime => _getFormattedConvertedTime();
  String get formattedInputTime => _getFormattedInputTime();

  void updateInputTime(DateTime time) {
    _timeConversionModel.inputTime = time;
    notifyListeners();
  }

  void updateInputTimeZone(String timeZone) {
    _timeConversionModel.inputTimeZone = timeZone;
    notifyListeners();
  }

  void updateOutputTimeZone(String timeZone) {
    _timeConversionModel.outputTimeZone = timeZone;
    notifyListeners();
  }

  void swapTimeZones() {
    String temp = _timeConversionModel.inputTimeZone;
    _timeConversionModel.inputTimeZone = _timeConversionModel.outputTimeZone;
    _timeConversionModel.outputTimeZone = temp;
    notifyListeners();
  }

  DateTime _getConvertedTime() {
    return TimeConversionService.convertTime(
        _timeConversionModel.inputTime,
        _timeConversionModel.inputTimeZone,
        _timeConversionModel.outputTimeZone);
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
      initialTime: TimeOfDay.fromDateTime(_timeConversionModel.inputTime),
    );
    if (picked != null) {
      updateInputTime(DateTime(
        _timeConversionModel.inputTime.year,
        _timeConversionModel.inputTime.month,
        _timeConversionModel.inputTime.day,
        picked.hour,
        picked.minute,
      ));
    }
  }
}
