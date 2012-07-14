//
//  NSURL+BrowserChooser.h
//  BrowserChooser
//
//  Created by Ellen Shapiro on 7/14/12.
//  Copyright (c) 2012 Designated Nerd Software.  
//



#import <Foundation/Foundation.h>

/**
 * Enum for supported browser types. 
 */
typedef enum {
    BrowserTypeMobileSafari = 0, 
    BrowserTypeChromeForiOS
} BrowserType;

@interface NSURL (BrowserChooser)

/**
 * Opens the NSURL in the indicated browser. 
 * @param browserType - The BrowserType as defined in the above enum you wish to use. 
 */
-(void)openInBrowser:(BrowserType)browserType;
@end
