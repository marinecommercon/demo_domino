//
//  MainViewController.m
//  domino
//
//  Created by Marine Commerçon on 04/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import "MainViewController.h"

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
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self setTime];
    [self setDate];
    
    if(IS_STANDARD_IPHONE_6){
        [_time setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:68]];
        [_date setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21]];
        //        [_notif setBackgroundImage:[UIImage imageNamed:@"6MainNotifGrise"] forState:UIControlStateHighlighted];
    } else if(IS_IPAD) {
        [_time setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:68]];
        [_date setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
        //        [_notif setBackgroundImage:[UIImage imageNamed:@"iMainNotifGrise"] forState:UIControlStateHighlighted];
    } else if(IS_IPHONE_4S) {
        [_time setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:54]];
        [_date setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        //        [_notif setBackgroundImage:[UIImage imageNamed:@"4MainNotifGrise"] forState:UIControlStateHighlighted];
    } else if(IS_STANDARD_IPHONE_6_PLUS){
        [_time setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:78]];
        [_date setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21]];
        //            [_notif setBackgroundImage:[UIImage imageNamed:@"6MainNotifGrise"] forState:UIControlStateHighlighted];
    }
    
    
    
    if(![defaults objectForKey:@"printerHidden"] == 1){
        UIImage *buttonImage = [UIImage imageNamed:@"printer"];
        [_buttonPrinter setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.view addSubview:_buttonPrinter];
        
    }
    else {
        [_buttonPrinter setBackgroundImage:nil forState:UIControlStateNormal];
    }
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

- (IBAction)buttonPrinter:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        UIPrinterPickerController *printerPicker = [UIPrinterPickerController printerPickerControllerWithInitiallySelectedPrinter:nil];
        
        //        [printerPicker presentAnimated:YES completionHandler:^(UIPrinterPickerController *printer, BOOL userDidSelect,NSError * error)
        
        
        [printerPicker presentFromRect:_buttonPrinter.frame inView:self.view animated:YES completionHandler:^(UIPrinterPickerController *printer, BOOL userDidSelect,NSError * error){
            
            if (userDidSelect) {
                [UIPrinterPickerController printerPickerControllerWithInitiallySelectedPrinter:printer.selectedPrinter];
                
                _printerURL = printer.selectedPrinter.URL;
                
                // Hide the button and memorize the choice
                [_buttonPrinter setBackgroundImage:nil forState:UIControlStateNormal];
                [self.view addSubview:_buttonPrinter];
                
                [defaults setValue:@"1" forKey:@"printerHidden"];
                [defaults setObject:[_printerURL absoluteString] forKey:@"printerURL"];
                [defaults synchronize];
            }
        }];
    }
}

- (void) setTime {
    NSDate * now = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *time = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:now]];
    _time.text = time;
}


@end
