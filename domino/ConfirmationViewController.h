//
//  ConfirmationViewController.h
//  domino
//
//  Created by Technique on 04/02/2016.
//  Copyright © 2016 Docapost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationViewController : UIViewController{
    NSString *firstName;
    NSString *lastName;
    NSString *address;
    NSString *cp;
    NSString *city;
}
@property(nonatomic,retain) NSString *firstName;
@property(nonatomic,retain) NSString *lastName;
@property(nonatomic,retain) NSString *address;
@property(nonatomic,retain) NSString *cp;
@property(nonatomic,retain) NSString *city;
@property (weak, nonatomic) IBOutlet UITextView *namesTextView;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet UIButton *back;
- (IBAction)back:(id)sender;
- (IBAction)validate:(id)sender;

@end
