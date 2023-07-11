import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsScreen extends StatefulWidget {
  @override
  _ComplaintsScreenState createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  double _sliderValue = 0.0;
  TextEditingController _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Complaints'),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How satisfied are you with our service?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            SfSlider(
              min: 0.0,
              max: 10.0,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              interval: 2,
              showTicks: true,
              showLabels: true,
              minorTicksPerInterval: 1,
              activeColor: Colors.blue,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _complaintController,
                decoration: InputDecoration(
                  labelText: 'Enter your complaint',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendComplaint();
              },
              child: Text('Submit Complaint'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendComplaint() async {
    try {
      final complaintsCollection =
          FirebaseFirestore.instance.collection('complaints');
      await complaintsCollection.add({
        'email': FirebaseAuth.instance.currentUser!.email,
        'rating': _sliderValue,
        'complaint': _complaintController.text,
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Complaint submitted successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      _complaintController.clear();
      setState(() {
        _sliderValue = 0.0;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit complaint.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Error submitting complaint: $e');
    }
  }
}
