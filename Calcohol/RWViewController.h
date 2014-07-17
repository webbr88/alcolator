//
//  RWViewController.h
//  Calcohol
//
//  Created by Renaldo Webb on 7/13/14.
//  Copyright (c) 2014 Renaldo Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultsLabel;

- (void)buttonPressed:(UIButton *)sender;


@end
