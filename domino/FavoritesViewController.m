//
//  FavoritesViewController.m
//  domino
//
//  Created by Marine Commerçon on 13/12/2015.
//  Copyright © 2015 Docapost. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    _back.adjustsImageWhenHighlighted = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
