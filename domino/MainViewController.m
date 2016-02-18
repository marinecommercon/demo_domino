//
//  MainViewController.m
//  domino
//
//  Created by Marine Commerçon on 04/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  
    [defaults setValue:@"0" forKey:@"showPopupText"];
    [defaults setValue:@"0" forKey:@"showPopup"];

    [self setNeedsStatusBarAppearanceUpdate];
    [self setTime];
    [self setDate];
    
    [_time setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:68]];
    [_date setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTime];
    [self setDate];
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) setDate {
    NSDate * now = [NSDate date];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"hh:mm";
    NSString *timeString = [timeFormatter stringFromDate:now];
    _time.text = timeString;
                           
    NSDateFormatter *numberFormatter = [[NSDateFormatter alloc] init];
    [numberFormatter setDateFormat:@"d"];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEEE"];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MMMM"];
    NSString *date = [NSString stringWithFormat:@"%@, %@ %@", [dayFormatter stringFromDate:now],
                      [monthFormatter stringFromDate:now],
                      [numberFormatter stringFromDate:now]];
    _date.text = date;
}

- (void) setTime {
    NSDate * now = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *time = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:now]];
    _time.text = time;
}


@end
