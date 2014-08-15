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
@property (weak, nonatomic) UILabel *beerCountLabel;
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
     self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; /*#bdecb6*/
    
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
    
    //Number of beers shown in label
    [self.beerCountLabel setText:[NSString stringWithFormat:@"%i", (int) self.beerCountSlider.value]];
    
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
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat viewWidth = screen.size.width;
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
        viewWidth = screen.size.width;
    }
    else{
        viewWidth = screen.size.height;
    }
    
    
    CGFloat padding;
    CGFloat itemWidth;
    CGFloat itemHeight;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         padding = 50;

         itemHeight = 100;
    }
    else{
         padding = 20;
         itemHeight = 44;
    }
    
    itemWidth = viewWidth - padding - padding;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding+60, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultsLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultsLabel.frame);
     self.beerCountLabel.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight+40);
    
    CGFloat bottomOfNumberOfBeers = CGRectGetMaxY(self.beerCountLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfNumberOfBeers + padding, itemWidth, itemHeight);
    
    
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
    int sliderValue;
    sliderValue = lroundf(sender.value);
    [sender setValue:sliderValue animated:YES];

    [self.beerPercentTextField resignFirstResponder];
    [self.beerCountLabel setText:[NSString stringWithFormat:@"%i", (int) sender.value]];
    
    self.title = [NSString stringWithFormat:@"%@ (%i)", NSLocalizedString(@"wine", @"glasses of wine"), (int)self.beerCountSlider.value];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
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
    UILabel *label2 = [[UILabel alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:label2];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultsLabel = label;
    self.beerCountLabel = label2;
    self.calculateButton = button;
    
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        // Since we don't have icons, let's move the title to the middle of the tab bar
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}



@end
