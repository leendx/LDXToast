//
//  ViewController.m
//  LDXToast
//
//  Created by Leen on 15/5/13.
//  Copyright (c) 2015年 leen. All rights reserved.
//

#import "ViewController.h"
#import "LDXToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showToast:(id)sender
{
    [LDXToast showToastWithText:@"I'm Toast!"];
}
@end
