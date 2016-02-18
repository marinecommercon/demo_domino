//
//  AddressViewController.m
//  domino
//
//  Created by Marine Commerçon on 05/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#define kDefaultPageHeight 792
#define kDefaultPageWidth  612

#define IS_IPHONE_4S (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 480.0))
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

#import "AddressViewController.h"
#import "ConfirmationViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController
@synthesize firstName;
@synthesize lastName;
@synthesize address;
@synthesize city;
@synthesize cp;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [firstName setDelegate:self];
    [lastName setDelegate:self];
    [address setDelegate:self];
    [city setDelegate:self];
    [cp setDelegate:self];
       
    // Set padding
    UIView *paddingView1    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView2    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView3    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView4    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView5    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    
    firstName.leftView = paddingView1;
    lastName.leftView  = paddingView2;
    address.leftView   = paddingView3;
    city.leftView      = paddingView4;
    cp.leftView        = paddingView5;
    
    firstName.leftViewMode = UITextFieldViewModeAlways;
    lastName.leftViewMode  = UITextFieldViewModeAlways;
    address.leftViewMode  = UITextFieldViewModeAlways;
    city.leftViewMode  = UITextFieldViewModeAlways;
    cp.leftViewMode  = UITextFieldViewModeAlways;
    
    firstName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    lastName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    address.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    firstName.autocorrectionType = UITextAutocorrectionTypeNo;
    lastName.autocorrectionType = UITextAutocorrectionTypeNo;
    address.autocorrectionType = UITextAutocorrectionTypeNo;
    city.autocorrectionType = UITextAutocorrectionTypeNo;
    
    cp.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    _back.adjustsImageWhenHighlighted = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(_moved) {
        [self animateViewToPosition:self.view directionUP:NO];
    }
    _moved = NO;
    return YES;
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonNext:(id)sender {
    if(firstName.text && firstName.text.length > 0 &&
       lastName.text  && lastName.text.length  > 0){
    
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:@"1" forKey:@"showPopupText"];

    ConfirmationViewController *confirmationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmation"];
    
    confirmationViewController.firstName = firstName.text;
    confirmationViewController.lastName = lastName.text;
    confirmationViewController.address = address.text;
    confirmationViewController.cp = cp.text;
    confirmationViewController.city = city.text;
    
    [self.navigationController pushViewController:confirmationViewController animated:YES];

    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(!_moved && IS_IPAD) {
        [self animateViewToPosition:self.view directionUP:YES];
        _moved = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}


-(void)animateViewToPosition:(UIView *)viewToMove directionUP:(BOOL)up {
    
    const int movementDistance = -60; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    viewToMove.frame = CGRectOffset(viewToMove.frame, 0, movement);
    [UIView commitAnimations];
}



@end
