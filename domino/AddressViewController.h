//
//  AddressViewController.h
//  domino
//
//  Created by Marine Commerçon on 05/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) UIPrinter *selectedPrinter;
@property (nonatomic,assign) BOOL moved;

- (IBAction)back:(id)sender;
- (IBAction)buttonNext:(id)sender;



-(NSString*)getPDFFileName;
+(void)drawPDF:(NSString*)fileName;
+(void)drawFlyer;
+(void)drawNameOnFlyer;
+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

@end

