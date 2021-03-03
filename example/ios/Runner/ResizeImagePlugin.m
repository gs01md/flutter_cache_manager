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
          if(imagePath == nil){
              result(@{@"res":@"error"});
          }
          
          UIImage *image = [UIImage imageNamed:imagePath];
          if(image == nil){
              result(@{@"res":@"error"});
          }
          
    #define MAX_IMAGE_WIDTH 2480
    #define MAX_IMAGE_HEIGHT 2480
          if((image.size.width > MAX_IMAGE_WIDTH) || (image.size.height > MAX_IMAGE_HEIGHT)){
              CGFloat scale = 1.0;
              scale = MIN(MAX_IMAGE_WIDTH / image.size.width, MAX_IMAGE_HEIGHT / image.size.height) ;
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
