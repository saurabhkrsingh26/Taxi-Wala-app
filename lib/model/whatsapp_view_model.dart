
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Send Message via WhatsApp'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {

            },
            child: Text('Send Message on WhatsApp'),
          ),
        ),
      ),
    );
  }

  // Function to send message via WhatsApp

}
