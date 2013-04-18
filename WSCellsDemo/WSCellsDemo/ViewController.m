//
//  ViewController.m
//  WSCellsDemo
//
//  Created by guo gloria on 13-4-17.
//  Copyright (c) 2013年 wshan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    // for the input file
    InputCell *_userCell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserName"];
    _userCell.title = @"Username";
    _userCell.position = InputCellPositionTop;
    _userCell.backgroundColor = C_CLEAR;
    _userCell.inputKeyboardType = UIKeyboardTypePhonePad;
    _userCell.frame = CGRectMake(0.0, 100, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT);
    _userCell.limitInputCharactersLength = 10;
    
    InputCell *_pwdCell = [[InputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Password"];
    _pwdCell.title = @"Password";
    _pwdCell.position = InputCellPositionBottom;
    _pwdCell.secureTextEntry = YES;
    _pwdCell.backgroundColor = C_CLEAR;
    _pwdCell.frame = CGRectMake(0.0, CGRectGetMaxY(_userCell.frame), UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT);
    
    [self.view addSubview:_userCell];
    [self.view addSubview:_pwdCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
