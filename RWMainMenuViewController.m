//
//  RWMainMenuViewController.m
//  Calcohol
//
//  Created by Renaldo Webb on 7/17/14.
//  Copyright (c) 2014 Renaldo Webb. All rights reserved.
//

#import "RWMainMenuViewController.h"
#import "RWWhiskeyViewController.h"
#import "RWMainMenuViewController.h"

@interface RWMainMenuViewController ()

@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation RWMainMenuViewController



- (void) winePressed:(UIButton *) sender {
    RWViewController *wineVC = [[RWViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    RWWhiskeyViewController *whiskeyVC = [[RWWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}




- (void)viewDidLoad
{
    // Calls the superclass's implementation
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Navigate to wine") forState:UIControlStateNormal];
    self.wineButton.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:20.0f];
    
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Navigate to Whiskey") forState:UIControlStateNormal];
    self.whiskeyButton.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:20.0f];

}


- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat itemWidth = 300;
    CGFloat itemHeight = 40;
    
    self.whiskeyButton.frame = CGRectMake(20, 140, itemWidth, itemHeight);
    self.wineButton.frame = CGRectMake(20, 80, itemWidth, itemHeight);
    
}


- (void)loadView {
    
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocation and initialize each of our views and the gesture recognizer
    UIButton *wineNavButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *whiskeyNavButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Add each view and the gesture recognizer as view's subviews
   [self.view addSubview:wineNavButton];
   [self.view addSubview:whiskeyNavButton];
    
    //Assign the views and gesture recognizer to our properties
    self.wineButton = wineNavButton;
    self.whiskeyButton = whiskeyNavButton;

}


@end
