//
//  LeenToast.m
//  CarRepair
//
//  Created by lin bin on 12-2-15.
//  Copyright 2012 __LeenDX__. All rights reserved.
//

#import "LDXToast.h"
#import <QuartzCore/QuartzCore.h>

static LDXToast *toast;

@implementation LDXToast

#define FontSize 17
#define LabelFont [UIFont fontWithName:@"Helvetica" size:FontSize]

+ (void) initialize
{
    // test recommended to avoid duplicate init via subclass
    if (self == [LDXToast class])
    {
        toast = [[LDXToast alloc] init];
    }
}

+ (LDXToast*) server
{
    return toast;
}

+ (void)showToastWithText:(NSString*)atext
{
    if (!toast) {
        toast = [super init];
    }
    [toast setText:atext];
    [toast show];
}
+ (void)showToastWithText:(NSString*)atext duration:(ToastDuration)duration
{
    if (!toast) {
        toast = [super init];
    }
    [toast setText:atext];
    [toast setDuration:duration];
    [toast show];
}

+ (void)showToastWithText:(NSString*)atext duration:(ToastDuration)duration gravity:(ToastGravity)gravity
{
    if (!toast) {
        toast = [super init];
    }
    [toast setText:atext];
    [toast setDuration:duration];
    [toast setGravity:gravity];
    [toast show];
}

-(id) init
{
    self = [super init];
    if(self)
    {
        durationTime = ToastDurationNormal;
        gravity      = ToastGravityBottom;
    }
    return  self;
}

-(id) initwithText:(NSString*)atext
{
    LDXToast *toast = [super init];
    if(toast)
    {
        durationTime = ToastDurationNormal;
        _text        = atext;
        gravity      = ToastGravityBottom;
    }
    return  toast;
}

-(void) setToastText:(NSString*)atext
{
    _text=atext;
}

- (void) show
{
	if (!view) {
		view=[[UIView alloc] init];
		view.layer.cornerRadius = 8;   
		view.layer.masksToBounds = YES;   
		//给图层添加一个有色边框   
		view.layer.borderWidth = 1;   
		view.layer.borderColor =[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75] CGColor];
		
		UILabel *label=[[UILabel alloc] init];
		label.tag=10;
		label.textAlignment=NSTextAlignmentCenter;
		label.numberOfLines=0;
		label.backgroundColor=[UIColor clearColor];
		label.textColor=[UIColor whiteColor];
        label.font = LabelFont;
		[view addSubview:label];
		
	}
	
	if(!_text)
	   _text=@"Hello";
	NSArray  *array  = [[UIApplication sharedApplication] windows];
	UIWindow *window = [array objectAtIndex:[array count]-1];
	
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        CGSize constraintSize = CGSizeMake(window.frame.size.height-40, MAXFLOAT);
        
        NSDictionary *attributes = @{NSFontAttributeName: LabelFont};
        CGRect textSize = [_text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGSize labelSize = textSize.size;
        view.frame=	CGRectMake(0, 0, labelSize.width+20, labelSize.height+20);
        view.center = CGPointMake(CGRectGetMidX(window.frame), CGRectGetMidY(window.frame)/2.f * gravity);
        view.userInteractionEnabled=YES;
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=_text;
        label.frame=CGRectMake(10, 10, labelSize.width, labelSize.height);
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2);//先顺时钟旋转90
        at =CGAffineTransformTranslate(at,200,0);
        [view setTransform:at]; 
    }
    else {
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        NSDictionary *attributes = @{NSFontAttributeName: LabelFont};
        CGRect textSize = [_text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        CGSize labelSize = textSize.size;
//        view.frame=	CGRectMake(window.center.x-labelSize.width/2-10, window.center.y-labelSize.height/2+140-gravity, labelSize.width+20, labelSize.height+20);
        
        view.frame=	CGRectMake(0, 0, labelSize.width+20, labelSize.height+20);
        view.center = CGPointMake(CGRectGetMidX(window.frame), CGRectGetMidY(window.frame)/2.f * gravity);
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=_text;
        label.frame=CGRectMake(6, 10, labelSize.width+4, labelSize.height);
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    view.alpha = 0;
	[window addSubview:view];
    
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1;
    } completion:^(BOOL finished) {
        
        if (timer) {
            [timer invalidate];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:durationTime target:self selector:@selector(timerEvent) userInfo:nil repeats:NO];
    }];
	
}


- (void)timerEvent
{
    [self dismiss];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
        if (view) {
            view = nil;
            timer = nil;
        }
    }];
}

- (void) setDuration:(ToastDuration) duration
{
    durationTime = duration;
}
-(void)setGravity:(ToastGravity)agravity
{
    gravity=agravity;
}
@end
