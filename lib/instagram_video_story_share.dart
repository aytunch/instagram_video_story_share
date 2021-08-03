
import 'dart:async';

import 'package:flutter/services.dart';

class InstagramVideoStoryShare {
  static const MethodChannel _channel =
      const MethodChannel('instagram_video_story_share');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
