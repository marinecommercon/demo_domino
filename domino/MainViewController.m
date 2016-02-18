//
//  MainViewController.m
//  domino
//
//  Created by Marine Commerçon on 04/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import "MainViewController.h"
#import "Mixpanel.h"

#define MIXPANEL_TOKEN @"f666678f13f344ecdd00d02df9c45ed5"


#define IS_IPHONE_4S (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 480.0))
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

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

    /**
    if(!IS_STANDARD_IPHONE_6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Small problem"
                                                        message:@"Sorry but this app is only adapted for iPhone 6S. You may have serious injuries if you continue."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
     **/
    
    // Initialize Mixpanel with your project token
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    
    // Tell iOS you want your app to receive push notifications
    // This code will work in iOS 8.0 xcode 6.0 or later:
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    // This code will work in iOS 7.0 and below:
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    // Call .identify to flush the People record to Mixpanel
    [mixpanel identify:mixpanel.distinctId];
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
