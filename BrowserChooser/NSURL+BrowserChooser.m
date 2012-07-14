//
//  NSURL+BrowserChooser.m
//  BrowserChooser
//
//  Created by Ellen Shapiro on 7/14/12.
//  Copyright (c) 2012 Designated Nerd Software.
//

#import "NSURL+BrowserChooser.h"

@implementation NSURL (BrowserChooser)

-(void)openInBrowser:(BrowserType)browserType 
{
    switch (browserType) {
        case BrowserTypeMobileSafari:
            //Open in default browser. This part's easy.
            [[UIApplication sharedApplication] openURL:self];
            break;
        case BrowserTypeChromeForiOS:
            //Check to make sure chrome is installed first:
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) {
                NSString *originalScheme = [self scheme];
                
                NSString *chromeSchemeToUse = nil;
                if ([originalScheme isEqualToString:@"http"]) {
                    chromeSchemeToUse = @"googlechrome";
                } else if ([originalScheme isEqualToString:@"https"]) {
                    chromeSchemeToUse = @"googlechromes";
                }
                
                //Proceed if there is a valid URL scheme available (things like ftp etc. will fail):
                if (chromeSchemeToUse) {
                    NSString *absoluteString = [self absoluteString];
                    NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
                    NSString *urlNoScheme = [absoluteString substringFromIndex:rangeForScheme.location];
                    NSString *chromeURLString = [chromeSchemeToUse stringByAppendingString:urlNoScheme];
                    NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
                    
                    [[UIApplication sharedApplication] openURL:chromeURL];
                } else {
                    //Inform the user the scheme could not be opened. 
                    NSString *title = NSLocalizedString(@"Sorry!", @"Sorry");
                    NSString *messagePrefix = NSLocalizedString(@"Google Chrome for iOS cannot open URLs that begin with", @"Chrome can't open prefix");
                    NSString *message = [NSString stringWithFormat:@"%@ %@.", messagePrefix, originalScheme];
                    NSString *ok = NSLocalizedString(@"OK", @"OK");

                    UIAlertView *noSchemeForYou = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:ok otherButtonTitles:nil];
                    [noSchemeForYou show];
                }
            } else {
                //Inform the user they need to install chrome. 
                NSString *title = NSLocalizedString(@"Oops!", @"Oops");
                NSString *message = NSLocalizedString(@"Chrome is not installed on your device. Please install Chrome on your device if you wish to open links with Chrome.", @"Chrome not installed, please install.");
                NSString *ok = NSLocalizedString(@"OK", @"OK");
                UIAlertView *noChromeForYou = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:ok otherButtonTitles:nil];
                [noChromeForYou show];
            }
            break;
        default:
            NSLog(@"Unknown browser type. Please check your code and try again.");
            break;
    }
}

@end
