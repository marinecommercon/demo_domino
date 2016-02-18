//
//  ConfirmationViewController.m
//  domino
//
//  Created by Technique on 04/02/2016.
//  Copyright © 2016 Docapost. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "HomeViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController
@synthesize firstName;
@synthesize lastName;
@synthesize address;
@synthesize cp;
@synthesize city;

- (void)viewDidLoad {
    [super viewDidLoad];
    _namesTextView.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];

    NSString *cpAndCity = [NSString stringWithFormat:@"%@ %@", cp, city];
    
    _addressTextView.text = [NSString stringWithFormat:@"%@\n%@\nFrance", address, cpAndCity];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)validate:(id)sender {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:[NSString stringWithFormat:@"La Poste vous remercie d’utiliser ses services et vous confirme que votre colis sera pris en charge demain pour être livré chez %@ %@.", firstName, lastName] forKey:@"popupText"];
    [defaults setValue:@"1" forKey:@"showPopupText"];
    [defaults setValue:@"1" forKey:@"showPopup"];
    
    HomeViewController *prevVC = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:prevVC animated:YES];
    
}
@end
