import 'package:flutter/material.dart';

class NetworkErrorContainer extends StatelessWidget {
  final int errorNumber;
  const NetworkErrorContainer({Key key, this.errorNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Network Error", style: TextStyle(color: Colors.green)),
      content: RichText(
        text: TextSpan(
            text: "Sorry, there was an error while sending a request to or getting a response from our server. ",
            style: TextStyle(fontSize: 15),
            children: [
              TextSpan(text: "Error number was: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "$errorNumber", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
            ]),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
