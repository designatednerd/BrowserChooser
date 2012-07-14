//
//  ViewController.m
//  BrowserChooser
//
//  Created by Ellen Shapiro on 7/14/12.
//  Copyright (c) 2012 Designated Nerd Software. 
//

#import "ViewController.h"
#import "NSURL+BrowserChooser.h"

@interface ViewController () 

@property (nonatomic, strong) NSArray *prefixTypes;
@property (nonatomic, strong) UIPickerView *prefixPicker;
@end

@implementation ViewController
@synthesize prefixButton = _prefixButton;
@synthesize urlTextField = _urlTextField;
@synthesize openInSafariButton = _openInSafariButton;
@synthesize openInChromeButton = _openInChromeButton;
@synthesize prefixTypes = _prefixTypes;
@synthesize prefixPicker = _prefixPicker;

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	//Setup supported prefix types.
    _prefixTypes = [NSArray arrayWithObjects:@"http://", @"https://", nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - IBActions
-(IBAction)launchPrefixPicker
{
    //If picker is null, set it up.
    if (!_prefixPicker) {
        _prefixPicker = [[UIPickerView alloc] init];
        _prefixPicker.dataSource = self;
        _prefixPicker.delegate = self;
        _prefixPicker.showsSelectionIndicator = YES;
        _prefixPicker.frame = CGRectOffset(_prefixPicker.frame, 0, self.view.frame.size.height);
    }
    
    //Add picker to view and animate in.
    [self.view addSubview:_prefixPicker];
    [UIView animateWithDuration:0.4 animations:^{
        _prefixPicker.frame = CGRectOffset(_prefixPicker.frame, 0, -_prefixPicker.frame.size.height);
    }];
}

-(IBAction)launchURL:(UIButton *)sender
{
    //Construct URL based on the prefix and entered text.
    NSString *prefix = _prefixButton.titleLabel.text;
    NSString *www = _urlTextField.text;
    NSString *urlString = [prefix stringByAppendingString:www];
    NSURL *urlToOpen = [NSURL URLWithString:urlString];
    
    //Open in the appropriate browser based on selected button. 
    if (sender == _openInSafariButton) {
        NSLog(@"Open %@ in Safari", urlString);
        [urlToOpen openInBrowser:BrowserTypeMobileSafari];
    } else if (sender == _openInChromeButton) {
        NSLog(@"Open %@ in Chrome", urlString);
        [urlToOpen openInBrowser:BrowserTypeChromeForiOS];
    } else {
        NSLog(@"Unknown Sender. Ya done goofed, son.");
    }
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [_prefixTypes count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_prefixTypes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Update prefix button title
    [_prefixButton setTitle:[_prefixTypes objectAtIndex:row] forState:UIControlStateNormal];
    
    //Animate picker out then remove from view.
    [UIView animateWithDuration:0.4 animations:^{
        _prefixPicker.frame = CGRectOffset(_prefixPicker.frame, 0, _prefixPicker.frame.size.height);
    } completion:^(BOOL finished) {
        [_prefixPicker removeFromSuperview];
    }];
}

#pragma mark - UITextFieldDelegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //If the user hits return, dismiss the keyboard rather than adding a newline. 
    [_urlTextField resignFirstResponder];
    return NO;
}
@end
