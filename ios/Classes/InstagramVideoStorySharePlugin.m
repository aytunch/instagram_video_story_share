#import "InstagramVideoStorySharePlugin.h"
#if __has_include(<instagram_video_story_share/instagram_video_story_share-Swift.h>)
#import <instagram_video_story_share/instagram_video_story_share-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "instagram_video_story_share-Swift.h"
#endif

@implementation InstagramVideoStorySharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstagramVideoStorySharePlugin registerWithRegistrar:registrar];
}
@end
