//
//  UIGestureRecognizer+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIGestureRecognizer (Blocks)

/**
 *  Convenience method to create gesture recognizer with block handler
 *
 *  @param block a block handler
 *
 *  @return an instance of UIGestureRecognizer or nil
 */
+ (id)gestureRecognizerWithBlock:(void(^)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state))block;

/**
 *  Initialize gesture recognizer with block handler
 *
 *  @param block a block handler
 *
 *  @return an instance of UIGestureRecognizer or nil
 */
- (id)initWithBlock:(void(^)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state))block;

@end
