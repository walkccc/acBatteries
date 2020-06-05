@interface BCBatteryDeviceController {
  NSArray* _sortedDevices;
}

+ (id)sharedInstance;
@end

@interface BCBatteryDevice {
  NSString* _name;
  long long _percentCharge;
}
@end

%hook UIViewController
- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion {
  // only affect UIAlertController
  if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
    UIAlertController *ac = (UIAlertController *)viewControllerToPresent;
    BCBatteryDeviceController *bdc = [%c(BCBatteryDeviceController) sharedInstance];
    NSArray *devices = MSHookIvar<NSArray *>(bdc, "_sortedDevices");
    NSMutableString *newMessage = [NSMutableString new];

    for (BCBatteryDevice *device in devices) {
      NSString *deviceName = MSHookIvar<NSString *>(device, "_name");
      long long deviceCharge = MSHookIvar<long long>(device, "_percentCharge");
      NSString *message = [NSString stringWithFormat:@"%@: %lld%%\n", deviceName, deviceCharge];
      [newMessage appendString:message];
    }

    // modify the message of all UIAlertControllers
    [ac setMessage:newMessage];
    return %orig(ac, flag, completion);
  }

  return %orig;
}
%end
