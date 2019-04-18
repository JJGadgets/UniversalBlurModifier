#import <UIKit/UIKit.h>

%hook _MTBackdropView
-(void)setBlurRadius:(double)arg1 {
	arg1 = 8;
}
%end