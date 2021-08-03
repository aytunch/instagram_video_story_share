import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_video_story_share/instagram_video_story_share.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool instagramInstalled = false;
  bool isLoading = false;
  bool isShared = false;

  String videoName = "sponty.mp4";

  @override
  void initState() {
    super.initState();
  }

  Future<String> videoFilePath() async {
    ByteData bytes = await rootBundle.load("assets/$videoName");
    String dir = (await getApplicationDocumentsDirectory()).path;
    //String dir = (await getTemporaryDirectory()).path;
    File file = await writeToFile(bytes, '$dir/$videoName');
    return file.path;
  }

  Future<File> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    File file = await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share video to Instagram Stories"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isLoading
                  ? "Loading..."
                  : isShared
                      ? "SHARED"
                      : "not shared yet",
            ),
            TextButton(
              onPressed: () async {
                print("checking if instagram is installed");
                try {
                  bool result =
                      await InstagramVideoStoryShare.instagramInstalled;
                  print("instagramInstalled: $result");
                  if (!mounted) return;
                  setState(() {
                    instagramInstalled = result;
                  });
                } on PlatformException catch (e) {
                  print("ERROR: $e");
                }
              },
              child: Text("Check if Instagram is installed"),
            ),
            Text(
              instagramInstalled ? "Instagram Installed" : "Check first..",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          String videoPath = await videoFilePath();
          print("videoPath: $videoPath");
          try {
            bool result =
                await InstagramVideoStoryShare.share(videoPath: videoPath);
            print("result: $result");
            if (!mounted) return;
            setState(() {
              isShared = result;
              isLoading = false;
            });
          } on PlatformException catch (e) {
            print("ERROR: $e");
          }
        },
        child: Icon(Icons.video_call),
      ),
    );
  }
}
