import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<Map<String, String>> feedback = [
    {
      'title': 'Saran',
      'value':
          'Saran saya mugnkin soal kuisnya bisa dipermudah dan lebih sedikit.'
    },
    {
      'title': 'Kesan',
      'value':
          'Kesan saya pada Kelas ini adalah saya merasa kelas ini selain meningkatkan kemampuan pemrograman mobile tapi juga mengajari bagaimana aplikasi tersebut bisa berjalan dengan lancar.'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue, // Replace with your desired color
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: feedback.length,
              itemBuilder: (context, index) {
                Map<String, String> fb = feedback[index];
                return _buildSection(fb);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, String> fb) {
    return Card(
      color: Colors.blue[50], // Ubah warna latar belakang card
      margin: EdgeInsets.symmetric(vertical: 8),

      child: ExpansionTile(
          title: Text(
            fb['title']!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(fb['value']!, style: TextStyle(fontSize: 18))),
          ]),
    );
  }
}
