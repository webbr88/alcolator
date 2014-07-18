//
//  RWViewController.m
//  Calcohol
//
//  Created by Renaldo Webb on 7/13/14.
//  Copyright (c) 2014 Renaldo Webb. All rights reserved.
//

#import "RWViewController.h"



@interface RWViewController () 

//@property (weak, nonatomic) UITextField *beerPercentTextField;
//@property (weak, nonatomic) UISlider *beerCountSlider;
//@property (weak, nonatomic) UILabel *resultsLabel;
//Why not the ones below?
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer  *hideKeyboardTapGestureRecognizer;

@end

@implementation RWViewController


- (void)viewDidLoad
{
    // Calls the superclass's implementation
    [super viewDidLoad];

    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    
    
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(SliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:20.0f];
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultsLabel.numberOfLines = 0;
}


- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
            CGFloat viewWidth = 768;
            CGFloat padding = 50;
            CGFloat itemWidth = viewWidth - padding - padding;
            CGFloat itemHeight = 100;
            
            self.beerPercentTextField.frame = CGRectMake(padding, padding+10, itemWidth, itemHeight);
            
            CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
            self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
            
            
            CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
            self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
            
            CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
            self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
        }
        
        else{
            CGFloat viewWidth = 1024;
            CGFloat padding = 50;
            CGFloat itemWidth = viewWidth - padding - padding;
            CGFloat itemHeight = 100;
            
            self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
            
            CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
            self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
            
            
            CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
            self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
            
            CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
            self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
            
            
        }

        
        
       
    }
    
    else{
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
                CGFloat viewWidth = 320;
                CGFloat padding = 20;
                CGFloat itemWidth = viewWidth - padding - padding;
                CGFloat itemHeight = 44;
    
                self.beerPercentTextField.frame = CGRectMake(padding, padding+10, itemWidth, itemHeight);
    
                CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
                self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    
                CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
                self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
                CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
                self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
        }
        
        else{
            CGFloat viewWidth = 480;
            CGFloat padding = 20;
            CGFloat itemWidth = viewWidth - padding - padding;
            CGFloat itemHeight = 44;
            
            self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
            
            CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
            self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
            
            
            CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
            self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
            
            CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
            self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
            
            
        }
        
    }
        
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}
- (void)SliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
}
- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultsLabel.text = resultText;
    self.resultsLabel.textColor = [UIColor blueColor];
    self.resultsLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:20.0f];
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    if ([self.beerPercentTextField isFirstResponder]) {
         [self.beerPercentTextField resignFirstResponder];
    }

    
}

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocation and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultsLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}


@end
