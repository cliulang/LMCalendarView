//
//  ViewController.m
//  CalendarDemo
//
//  Created by zero on 15/6/16.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "ViewController.h"
#import "LMCalendarView.h"

@interface ViewController ()
{
    LMCalendarView* calendar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    
    calendar = [[LMCalendarView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 400)];
    [self.view addSubview:calendar];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 30, 80, 40);
    [btn setTitle:@"今日" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(todayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)todayAction{
    [calendar updateToCurrentMonth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
