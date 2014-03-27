//
//  ViewController.m
//  JOECurrencyUtil
//
//  Created by Joseph Collins on 3/27/14.
//  Copyright (c) 2014 Joseph Collins. All rights reserved.
//

#import "ViewController.h"
#import "JOECurrencyUtil.h"

@interface ViewController ()
@property (strong, nonatomic) JOECurrencyUtil *currencyUtil;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRegionFormat:) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:@"11.25"];
    
    self.textLabel.text = [JOECurrencyUtil stringFromDecimalNumber:decimalNumber];
    
    self.decimalLabel.text = [[JOECurrencyUtil decimalNumberFromCurrencyString:self.textLabel.text] stringValue];
    
}

- (void)updateRegionFormat:(NSNotification *)object
{
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:@"11.25"];
    
    self.textLabel.text = [JOECurrencyUtil stringFromDecimalNumber:decimalNumber];
    
    self.decimalLabel.text = [[JOECurrencyUtil decimalNumberFromCurrencyString:self.textLabel.text] stringValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
