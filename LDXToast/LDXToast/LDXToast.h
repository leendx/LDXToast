//
//  LDXToast.h
//
//  Created by lin bin on 12-2-15.
//  Copyright 2012 __LeenDX__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum ToastGravity {
	
    ToastGravityTop = 1,
    
    ToastGravityCenter = 2,
	
	ToastGravityBottom = 3,
	
	
}ToastGravity;

typedef enum ToastDuration {
	
	ToastDurationLong = 7,
	
	ToastDurationShort = 1,
	
	ToastDurationNormal = 3
	
}ToastDuration;

typedef enum ToastType {
	
	ToastTypeInfo = -100000,
	
	ToastTypeNotice,
	
	ToastTypeWarning,
	
	ToastTypeError
	
}ToastType;


@interface LDXToast : NSObject {
	NSTimer *timer;
	UIView *view;
    ToastDuration durationTime;
    ToastGravity gravity;
}

@property(retain,nonatomic)NSString *text;

+ (LDXToast*) server;
+ (void) showToastWithText:(NSString*)atext;
+ (void) showToastWithText:(NSString*)atext duration:(ToastDuration)duration;
+ (void) showToastWithText:(NSString*)atext duration:(ToastDuration)duration gravity:(ToastGravity)gravity;

- (id)   initwithText:(NSString*)atext;

- (void) show;
- (void) dismiss;

- (void) setDuration:(ToastDuration) duration;
- (void) setToastText:(NSString*)atext;
- (void) setGravity:(ToastGravity)agravity;

@end

