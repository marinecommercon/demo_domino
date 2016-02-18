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
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *cp;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (nonatomic,assign) BOOL moved;

- (IBAction)back:(id)sender;
- (IBAction)buttonNext:(id)sender;

@end
