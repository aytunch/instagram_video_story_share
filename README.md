# instagram_video_story_share

A Flutter Plugin for iOS which shares a video file to be posted as an Instagram Story

We needed a way to share videos for our social media app in Instagram stories like TikTok is doing but we could not find a plugin which allows this.

You can check the live functionality by installing our app

[Sponty: Spontaneous social gatherings](https://sponty.app/#/)

![Sponty Logo](pics/sponty.png)

All the other plugins supported images and the ones supporting videos were only sharing to Instagram Feed and not Stories.

This API from "Facebook for developers" is followed while implementing the plugin:

[Sharing to Stories](https://developers.facebook.com/docs/instagram/sharing-to-stories)

If the community asks for it, we can add functionality for editable stickers in Instagram stories to be passed from Flutter

**This plugin is only for iOS**

PR's for Android offering same functionality are welcome

## Video story share on Instagram

![insta story share demo](gifs/insta.gif)

## iOS Configuration

#### Set your minimum iOS version to 10.0 or higher

#### Add this to your `Info.plist` to use share on instagram stories

```
<key>LSApplicationQueriesSchemes</key>
	<array>
	<string>instagram-stories</string>
	</array>
```

## Usage

To check if Instagram is installed:

```dart
bool isInstagramInstalled = await InstagramVideoStoryShare.instagramInstalled;
```

To share a video in your Instagram Stories:

```dart
bool success = await InstagramVideoStoryShare.share(videoPath: myVideoPath);
```

To get the video path you might need to use `path_provider` package as seen in the example project:

```
  # in your pubspec.yaml file add this:
  path_provider: ^2.0.2
```

```dart
  import 'dart:io';
  import 'package:path_provider/path_provider.dart';

  Future<String> videoFilePath() async {
    ByteData bytes = await rootBundle.load("assets/$videoName");
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = await writeToFile(bytes, '$dir/$videoName');
    return file.path;
  }

  Future<File> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    File file = await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return file;
  }
```
