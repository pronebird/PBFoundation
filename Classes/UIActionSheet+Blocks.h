//
//  UIActionSheet+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Blocks)

/**
 *  Alternative initializer for UIActionSheet
 *
 *  @param title an action sheet title
 *
 *  @return an instance of UIActionSheet or nil
 */
- (id)initWithTitle:(NSString*)title;

/**
 *  Add button with block handler
 *
 *  @param title a button title
 *  @param block a handler block
 */
- (void)addButtonWithTitle:(NSString*)title block:(void(^)(void))block;

/**
 *  Add cancel button with block handler
 *
 *  @param title a cancel button title
 *  @param block a handler block
 */
- (void)addCancelButtonWithTitle:(NSString*)title block:(void(^)(void))block;

/**
 *  Add destructive button with block handler
 *
 *  @param title a destructive button title
 *  @param block a handler block
 */
- (void)addDestructiveButtonWithTitle:(NSString*)title block:(void(^)(void))block;

@end
