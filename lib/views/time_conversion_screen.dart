import 'package:fgo_app/controllers/time_controller.dart';
import 'package:fgo_app/models/time_conversion.dart';
import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TimeConversionController _timeController = TimeConversionController();

  @override
  void initState() {
    super.initState();
    // _timeController.addListener(_updateState);
  }

  @override
  void dispose() {
    // _timeController.removeListener(_updateState);
    // _timeController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Conversion',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<TimeConversion>(
            valueListenable: _timeController.timeConversionModel,
            builder: (context, timeModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Time:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _timeController.selectTime(context),
                    child: Text('Pick Time'),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: _timeController.inputTimeZone,
                        items: [
                          'WIB',
                          'WITA',
                          'WIT',
                          'London (GMT)',
                          'London (BST)',
                          'JST'
                        ].map((String zone) {
                          return DropdownMenuItem<String>(
                            value: zone,
                            child: Text(zone),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _timeController.updateInputTimeZone(newValue);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.swap_horiz),
                        onPressed: _timeController.swapTimeZones,
                      ),
                      DropdownButton<String>(
                        value: _timeController.outputTimeZone,
                        items: [
                          'WIB',
                          'WITA',
                          'WIT',
                          'London (GMT)',
                          'London (BST)',
                          'JST'
                        ].map((String zone) {
                          return DropdownMenuItem<String>(
                            value: zone,
                            child: Text(zone),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _timeController.updateOutputTimeZone(newValue);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _timeShow(_timeController.inputTimeZone,
                          _timeController.formattedInputTime),
                      _timeShow(_timeController.outputTimeZone,
                          _timeController.formattedConvertedTime)
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _timeShow(String timeZone, String formattedTime) {
    return Column(
      children: [
        Text(
          timeZone,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          formattedTime,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
