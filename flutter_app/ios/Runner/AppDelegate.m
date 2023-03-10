#include "AppDelegate.h"
#import <Flutter/Flutter.h>
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

      FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"samples.flutter.io/battery"
                                              binaryMessenger:controller];
        __weak typeof(self) weakSelf = self;
      [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int batteryLevel = [weakSelf getBatteryLevel];
            if (batteryLevel == -1) {
              result([FlutterError errorWithCode:@"UNAVAILABLE"
                                         message:@"Battery info unavailable"
                                         details:nil]);
            } else {
              result(@(batteryLevel));
            }
          } else {
            result(FlutterMethodNotImplemented);
          }
      }];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
- (int)getBatteryLevel {
    
    
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
     [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    NSLog(@"电池电量：%.2f", [UIDevice currentDevice].batteryLevel);
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
      NSLog(@"unkown");
    return 20;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
