import Flutter
import UIKit

public class SwiftInstagramVideoStorySharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "instagram_video_story_share", binaryMessenger: registrar.messenger())
    let instance = SwiftInstagramVideoStorySharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
