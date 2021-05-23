import 'package:flutter/material.dart';
import 'package:imagerecognition/single_image.dart';

void main() {
  runApp(MyApp());
}

void tmpFunction(BuildContext context, String imageName) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => RecognitionResult(
              imageName: imageName,
            )),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Center(
          child: Scaffold(
              appBar: AppBar(
                title: Text('Flutter image recognition'),
                backgroundColor: Colors.deepPurple[400],
              ),
              body: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select a photo for recognition!",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[600]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image1.jpeg");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image1.jpeg'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image2.jpeg");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image2.jpeg'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image3.jpeg");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image3.jpeg'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image4.png");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image4.png'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image5.jpeg");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image5.jpeg'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              tmpFunction(context, "image6.png");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/image6.png'),
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])),
              )),
        ),
      ),
    );
  }
}
