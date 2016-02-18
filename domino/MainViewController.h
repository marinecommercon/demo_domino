//
//  MainViewController.h
//  domino
//
//  Created by Marine Commerçon on 04/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) NSURL *printerURL;
@property (weak, nonatomic) IBOutlet UIButton *buttonPrinter;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UIButton *notif;


- (IBAction)buttonPrinter:(id)sender;
- (void) getTime;
- (void) getDate;




@end
