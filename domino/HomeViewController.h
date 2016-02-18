//
//  HomeViewController.h
//  domino
//
//  Created by Marine Commerçon on 10/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *popup;

- (IBAction)back:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)buttonPopup:(id)sender;

@end
