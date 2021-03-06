import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        detectedText =
            detectedText + body['details'][i]['DetectedText'] + " \n";
      }
    }
    return detectedText;
  } catch (e) {
    return "Could not analyse the text!";
  }
}

class RecognitionResult extends StatefulWidget {
  final imageName;
  final imagePath;
  const RecognitionResult({
    this.imageName,
    this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  _RecognitionResultState createState() =>
      _RecognitionResultState(imageName: imageName, imagePath: imagePath);
}

class _RecognitionResultState extends State<RecognitionResult> {
  String _result = "initializing...\n";
  final imageName;
  final imagePath;
  _RecognitionResultState({this.imageName, this.imagePath}) : super();

  @override
  Widget build(BuildContext context) {
    print("imageName: ${imageName}");
    print("imagePath: ${imagePath}");

    return Scaffold(
        appBar: AppBar(
          title: Text("Analyse your image"),
          backgroundColor: Colors.deepPurple[400],
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imagePath),
                width: 300,
                height: 300,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    _result,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    softWrap: true,
                  ),
                ),
              ),
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
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate back to first route when tapped.
                  },
                  child: Text('Go back'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurple[400]!),
                  ),
                ),
              ),
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurple[400]!),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
