//
//  DeviceInfoPlugin.m

#import "ResizeImagePlugin.h"

@implementation ResizeImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:RESIZE_IMAGE_CHANNEL
            binaryMessenger:[registrar messenger]];
    ResizeImagePlugin* instance = [[ResizeImagePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"resizeImage" isEqualToString:call.method]) {
          
          NSDictionary* params = (NSDictionary *)call.arguments;
    //      NSLog(@"%@", params);
          NSString* imagePath = [params objectForKey:@"imagePath"];
          NSString* url = [params objectForKey:@"url"];
          if(imagePath == nil || url == nil){
              result(@{@"res":@"error"});
          }
          
          UIImage *image = [UIImage imageNamed:imagePath];
          if(image == nil){
              result(@{@"res":@"error"});
          }
        #define MAX_IMAGE_WIDTH(url) ([url containsString:@"https://cdn.lingoace.com/avatar"] ? 414. : 2480.)
        #define MAX_IMAGE_HEIGHT(url) ([url containsString:@"https://cdn.lingoace.com/avatar"] ? 414. : 2480.)
            if((image.size.width > MAX_IMAGE_WIDTH(url)) || (image.size.height > MAX_IMAGE_HEIGHT(url))){
              CGFloat scale = 1.0;
              scale = MIN(MAX_IMAGE_WIDTH(url) / image.size.width, MAX_IMAGE_HEIGHT(url) / image.size.height) ;
              CGSize size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(scale, scale));
              CGFloat scaleScreen = 0.0; // Automatically use scale factor of main screen
              UIGraphicsBeginImageContextWithOptions(size, false, scaleScreen);
              [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
              UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
              UIGraphicsEndImageContext();
              NSData *data = UIImageJPEGRepresentation(scaledImage, 0.7);
              [data writeToFile:imagePath atomically:YES];
          }
          
          result(@{@"res":@"success"});
      }else {
      result(FlutterMethodNotImplemented);
  }
}


@end
