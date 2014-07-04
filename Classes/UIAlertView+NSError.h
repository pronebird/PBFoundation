//
//  UIAlertView+NSError.h
//  PBFoundation
//
//  Created by pronebird on 8/30/13.
//  Copyright (c) 2013 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIAlertView (NSError)

/**
 *  Show alert view with NSError as message.
 *  Recovery suggestion is added to message if available.
 *
 *  @param error an instance of NSError
 */
+ (void)showWithError:(NSError*)error;

/**
 *  Show alert view with title and NSError as message.
 *  Recovery suggestion is added to message if available.
 *
 *  @param title an alert view title
 *  @param error an instance of NSError
 */
+ (void)showWithTitle:(NSString*)title error:(NSError*)error;

@end
