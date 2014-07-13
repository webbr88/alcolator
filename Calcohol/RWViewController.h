//
//  RWViewController.h
//  Calcohol
//
//  Created by Renaldo Webb on 7/13/14.
//  Copyright (c) 2014 Renaldo Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (strong, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;

@end
