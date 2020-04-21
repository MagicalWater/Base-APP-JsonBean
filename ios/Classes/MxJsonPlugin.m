#import "MxJsonPlugin.h"
#import <mx_json/mx_json-Swift.h>

@implementation MxJsonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMxJsonPlugin registerWithRegistrar:registrar];
}
@end
