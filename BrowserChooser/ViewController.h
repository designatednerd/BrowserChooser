//
//  ViewController.h
//  BrowserChooser
//
//  Created by Ellen Shapiro on 7/14/12.
//  Copyright (c) 2012 Designated Nerd Software. 
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *prefixButton;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *openInSafariButton;
@property (strong, nonatomic) IBOutlet UIButton *openInChromeButton;
@end
