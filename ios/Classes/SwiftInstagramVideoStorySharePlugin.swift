import Flutter
import UIKit

public class SwiftInstagramVideoStorySharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "instagram_video_story_share", binaryMessenger: registrar.messenger())
    let instance = SwiftInstagramVideoStorySharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "shareVideoToInstagramStories" :
            var resultDictionary: [String: Any] = [:]
            resultDictionary["result"] = false
            resultDictionary["message"] = "Message From Swift: ___"
            guard let args = call.arguments else {
                print("Unexpected error ARGS HAVE A PROBLEM.")
                resultDictionary["result"] = false
                resultDictionary["message"] = "Message From Swift error ARGS HAVE A PROBLEM"
                result(resultDictionary)
                return
            }
            let videoPath = args as? String
            print("videoPath: \(videoPath ?? "unknown")")
            let instagramUrl = URL(string: "instagram-stories://share")
            if UIApplication.shared.canOpenURL(instagramUrl!) {
                print("Instagram is installed")
                let documentExists = FileManager.default.fileExists(atPath: videoPath!)
                print("documentExists: \(documentExists)")
                if(documentExists) {
                    do {
                        let video = try NSData(contentsOfFile: videoPath!, options: .mappedIfSafe)
                        var pasterboardItems:[[String:Any]]? = nil
                        pasterboardItems = [["com.instagram.sharedSticker.backgroundVideo": video as Any]]
                        UIPasteboard.general.setItems(pasterboardItems!)
                        UIApplication.shared.open(instagramUrl!)
                        resultDictionary["result"] = true
                        resultDictionary["message"] = "Message From Swift \(videoPath ?? "unknown")"
                    } catch {
                        print("Unexpected error converting to NSDATA: \(error).")
                        resultDictionary["result"] = false
                        resultDictionary["message"] = "Message From Swift error converting to NSDATA"
                    }
                } else {
                    print("Unexpected error DOCUMENT DOES NOT EXIST.")
                    resultDictionary["result"] = false
                    resultDictionary["message"] = "Message From Swift error DOCUMENT DOES NOT EXIST"
                }
            } else {
                print("Instagram is not installed")
                resultDictionary["result"] = false
                resultDictionary["message"] = "Message From Swift INSTAGRAM NOT INSTALLED"
            }
            print("resultDictionary: \(resultDictionary)")
            result(resultDictionary)
        case "isInstagramInstalled" :
            let instagramUrl = URL(string: "instagram-stories://share")
            if UIApplication.shared.canOpenURL(instagramUrl!) {
                result(true)
            } else {
                result(false)
            }
        default :
            result(FlutterMethodNotImplemented)
    }
  }
}
