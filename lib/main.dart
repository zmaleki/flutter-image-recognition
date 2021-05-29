import 'package:flutter/material.dart';
import 'package:imagerecognition/single_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import './amplify/amplifyconfiguration.dart';
import 'dart:io';

void main() {
  runApp(MyApp(title: 'Flutter Recognition Page'));
}

void openRecognitionRoute(
    BuildContext context, String imageName, String imagePath) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => RecognitionResult(
              imageName: imageName,
              imagePath: imagePath,
            )),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  final List<String> _files = <String>['assets/images/image2.jpeg'];
  final List<String> _fileNames = <String>['image2.jpeg'];

  void initState() {
    super.initState();
  }

  void configureAmplify() async {
    // First add plugins (Amplify native requirements)
    AmplifyStorageS3 storage = new AmplifyStorageS3();
    AmplifyAuthCognito auth = new AmplifyAuthCognito();
    Amplify.addPlugins([auth, storage]);

    try {
      // Configure
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          'Amplify was already configured. Looks like app restarted on android.');
    }

    setState(() {
      _isAmplifyConfigured = true;
    });
  }

  void upload() async {
    try {
      print('In upload');
      // Uploading the file with options
      FilePickerResult? fileResult =
          await FilePicker.platform.pickFiles(type: FileType.image);
      print(fileResult);
      File local = File(fileResult?.files.single.path ?? "");
      final key = fileResult?.files.single.name;

      Map<String, String> metadata = <String, String>{};
      metadata['name'] = 'filename';
      metadata['desc'] = 'A test file';
      S3UploadFileOptions options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest, metadata: metadata);
      await Amplify.Storage.uploadFile(
          key: key, local: local, options: options);
      print("key${key}");
      setState(() {
        _files.add(local.path);
        _fileNames.add(key!);
      });
    } catch (e) {
      print('UploadFile Err: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _isAmplifyConfigured ? null : configureAmplify();
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
                    SizedBox(
                      height: 600.0,
                      child: new ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _files.length,
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                openRecognitionRoute(
                                    context, _fileNames[index], _files[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                ),
                                child: Image(
                                  image: AssetImage(_files[index]),
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            );
                          }),
                    ),
                  ])),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: upload,
              tooltip: 'upload',
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
