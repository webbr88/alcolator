//
//  RWWhiskeyViewController.m
//  Calcohol
//
//  Created by Renaldo Webb on 7/16/14.
//  Copyright (c) 2014 Renaldo Webb. All rights reserved.
//

#import "RWWhiskeyViewController.h"

@interface RWWhiskeyViewController ()

@end

@implementation RWWhiskeyViewController


// DELETE PRE-WRITTEN METHODS: initiWithNibName:bundle:, viewDidLoad, didReceiveMemoryWarning…

- (void)buttonPressed:(UIButton *)sender;
[self.beerPercentTextField resignFirstResponder];

int numberOfBeers = self.beerCountSlider.value;
int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles

float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;

float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
float alcoholPercentageOfWhiskey = 0.4;  // 40% is average

float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;

NSString *beerText;

if (numberOfBeers == 1) {
    beerText = NSLocalizedString(@"beer", @"singular beer");
} else {
    beerText = NSLocalizedString(@"beers", @"plural of beer");
}

NSString *whiskeyText;

if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
    whiskeyText = NSLocalizedString(@"shot", @"singular shot");
} else {
    whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
}

NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
self.resultLabel.text = resultText;
}

@end
