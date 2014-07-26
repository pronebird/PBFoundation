//
//  UIAlertView+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIAlertView (Blocks)

/**
 *  Convenience method to show alert view with title, message and cancel button
 *
 *  @param title             an alert view title
 *  @param message           an alert view message
 *  @param cancelButtonTitle a cancel button title
 */
+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle;

/**
 *  Convenience method to create alert view with title and message
 *
 *  @param title   a title
 *  @param message a message
 *
 *  @return an instance of UIAlertView or nil
 */
+ (id)alertViewWithTitle:(NSString*)title message:(NSString*)message;

/**
 *  Convenience method to create alert view with title, message and cancel button
 *
 *  @param title             a title
 *  @param message           a message
 *  @param cancelButtonTitle a cancel button title
 *
 *  @return an instance of UIAlertView or nil
 */
+ (id)alertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle;

/**
 *  Alternative initialzer for UIAlertView
 *
 *  @param title             a title
 *  @param message           a message
 *  @param cancelButtonTitle a cancel button title
 *
 *  @return an instance of UIAlertView or nil
 */
- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle;

/**
 *  Add button with block handler
 *
 *  @param title a button title
 *  @param block a handler block
 *
 *  @return an index of added button
 */
- (NSInteger)addButtonWithTitle:(NSString*)title block:(void(^)(void))block;

/**
 *  Add cancel button with block handler
 *
 *  @param title a button title
 *  @param block a handler block
 *
 *  @return an index of added button
 */
- (NSInteger)addCancelButtonWithTitle:(NSString*)title block:(void(^)(void))block;

/**
 *  Set block handler for button with index
 *
 *  @param block a handler block
 *  @param buttonIndex an button index
 */
- (void)setBlock:(void(^)(void))block forButtonAtIndex:(NSInteger)buttonIndex;

/**
 *  Set block for alertViewShouldEnableFirstOtherButton: delegate method
 *
 *  @param block a block handler
 */
- (void)setShouldEnableFirstOtherButtonBlock:(BOOL(^)(UIAlertView* alertView))block;

@end
