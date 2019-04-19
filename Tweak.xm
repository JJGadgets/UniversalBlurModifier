#import <UIKit/UIKit.h>

@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString *nsDomainString = @"com.jjgadgets.uniblurmod";
static NSString *nsNotificationString = @"com.jjgadgets.uniblurmod/preferences.changed";
static BOOL enable;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber *n = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enable" inDomain:nsDomainString];
	enable = (n)? [n boolValue]:YES;
}

%ctor {
  notificationCallback(NULL, NULL, NULL, NULL, NULL);
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                  NULL, notificationCallback,
                                  (CFStringRef)nsNotificationString, NULL,
                                  CFNotificationSuspensionBehaviorCoalesce);
  NSNumber *e = (NSNumber *)[[NSUserDefaults standardUserDefaults]
      objectForKey:@"enable"
          inDomain:nsDomainString];
  enable = (e) ? [e boolValue] : NO;
  // NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]
  // initWithContentsOfFile:nsDomainString];
  bundleID = [[NSBundle mainBundle] bundleIdentifier];
  NSLog(@"YEOT %@", bundleID);
  reloadPrefs();
  if (enable) {
    %init(_ungrouped);
  }
}

%hook _MTBackdropView
-(void)setBlurRadius:(double)arg1 {
	return %orig(8);
}
%end