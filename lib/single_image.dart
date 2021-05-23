import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'result.dart';

analyseFunction(String imageName) async {
  try {
    var result = await http.post(
      Uri.parse(
          'https://gjub2trxq8.execute-api.ap-southeast-2.amazonaws.com/prod/detectText'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fileName': imageName,
      }),
    );
    var body = jsonDecode(result.body);
    print(body['details']);
    if (body['details'].length == 0) {
      return "No text is found";
    }
    var detectedText = "";
    for (var i = 0; i < body['details'].length; i++) {
      if (body['details'][i]['Type'] == 'LINE') {
        detectedText = detectedText + body['details'][i]['DetectedText'] + " ";
      }
    }
    // var firstItem = body['details'][0];
    // return firstItem['DetectedText'];
    return detectedText;
  } catch (e) {
    return "Could not analyse the text!";
  }
  // return result;
}

class RecognitionResult extends StatefulWidget {
  final imageName;
  // SecondRoute({key, this.imageName}) : super(key: key);
  const RecognitionResult({
    this.imageName,
    Key? key,
  }) : super(key: key);

  @override
  _RecognitionResultState createState() =>
      _RecognitionResultState(imageName: imageName);
}

class _RecognitionResultState extends State<RecognitionResult> {
  String _result = "initializing...";
  final imageName;
  _RecognitionResultState({
    this.imageName,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Route"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/$imageName'),
                width: 300,
                height: 300,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_result),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await analyseFunction(imageName);
                    setState(() {
                      _result = result;
                    });
                  },
                  child: Text('Analyse'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate back to first route when tapped.
                  },
                  child: Text('Go back'),
                ),
              ),
            ],
          ),
        ]));
  }
}
