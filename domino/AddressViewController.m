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

@interface AddressViewController ()

@end

@implementation AddressViewController
@synthesize firstName;
@synthesize lastName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [firstName setDelegate:self];
    [lastName setDelegate:self];
    
    // Set padding
    UIView *paddingView1    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView2    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    firstName.leftView     = paddingView1;
    lastName.leftView      = paddingView2;
    firstName.leftViewMode = UITextFieldViewModeAlways;
    lastName.leftViewMode  = UITextFieldViewModeAlways;
    firstName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    lastName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
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
       lastName.text && lastName.text.length > 0){
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        NSString* fileName = [self getPDFFileName];
        NSString *combined = [NSString stringWithFormat:@"%@ %@", firstName.text, lastName.text];
        [AddressViewController drawPDF:fileName withName:combined];
        
        UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
        
        printController.delegate = self;
        
        if(![defaults objectForKey:@"printerURL"] == NULL){
            
            self.selectedPrinter = [UIPrinter printerWithURL:[NSURL URLWithString:[defaults objectForKey:@"printerURL"]] ];
            if (self.selectedPrinter) {
                
                UIPrintInfo *printInfo = [UIPrintInfo printInfo];
                printInfo.outputType = UIPrintInfoOutputGeneral;
                printInfo.outputType = UIPrintInfoOrientationPortrait;
                printInfo.jobName = @"Print Template";
                printController.printInfo = printInfo;
                
                NSString* path = [self getPDFFileName];
                NSURL* imageURL = [NSURL fileURLWithPath:path isDirectory:NO];
                printController.printingItem = imageURL;
                
                [printController printToPrinter:self.selectedPrinter completionHandler:^(UIPrintInteractionController *printController, BOOL completed, NSError *error){
                    
                    if (completed) {
                        NSLog(@"printing successfully completed");
                        [defaults setValue:@"1" forKey:@"showPopup"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                    else{
                        NSLog(@"error occured while printing");
                    }
                }];
            }
        }
    }
}

-(NSString*)getPDFFileName
{
    NSString* fileName = @"Invoice.PDF";
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    return pdfFileName;
}

+(void)drawPDF:(NSString*)fileName withName:(NSString*)name
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth,
                                              kDefaultPageHeight), nil);
    [self drawFlyer];
    [self drawNameOnFlyer:name];
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawFlyer
{
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"Flyer" owner:nil options:nil];
    UIView* mainView = [objects objectAtIndex:0];
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
            UIImage* logo = [UIImage imageNamed:@"flyer.png"];
            [self drawImage:logo inRect:view.frame];
        }
    }
}

+(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    [image drawInRect:rect];
}

+ (void)drawNameOnFlyer:(NSString*)nameString
{
    UIFont* theFont = [UIFont fontWithName:@"Helvetica" size:24];
    
    CGSize nameStringSize = [nameString sizeWithAttributes:
                             @{NSFontAttributeName:
                                   theFont}];
    CGRect stringRect = CGRectMake(60.0,
                                   490.0 + ((72.0 - nameStringSize.height) / 2.0) ,
                                   520.0,
                                   nameStringSize.height);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:24],
                                 NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName: paragraphStyle, NSKernAttributeName : @(1.3f)};
    
    [nameString drawInRect:stringRect withAttributes:attributes];
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
