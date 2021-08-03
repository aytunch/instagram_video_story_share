# instagram_video_story_share

A Flutter Plugin for iOS which shares a video file to be posted as an Instagram Story

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

To get the video path you might need to use path_provider package as seen in the example project:

```dart
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
