//
//  UIView+Traverse.h
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Traverse)

/**
 *  Find first view matching class name prefix
 *
 *  @param prefix a prefix to match against
 *
 *  @return an UIView instance
 */
- (UIView*)findFirstViewWithClassPrefix:(NSString*)prefix;

/**
 *  Find first view matching class name suffix
 *
 *  @param suffix a suffix to match against
 *
 *  @return an UIView instance
 */
- (UIView*)findFirstViewWithClassSuffix:(NSString*)suffix;

/**
 *  Find first view matching class
 *
 *  @param aClass a Class object to match against
 *  @param depth  a maximum depth of traverse. Pass 0 for unlimited.
 *
 *  @return an instance of UIView, otherwise nil
 */
- (UIView*)findFirstViewMatchingClass:(Class)aClass depth:(NSUInteger)depth;

/**
 *  Find views matching class
 *
 *  @param aClass a Class object to match against
 *  @param depth  a maximum depth of traverse. Pass 0 for unlimited.
 *
 *  @return an array of UIView instances
 */
- (NSArray*)findAllViewsMatchingClass:(Class)aClass depth:(NSUInteger)depth;

/**
 *  Find views matching class name suffix
 *
 *  @param suffix a suffix to match against
 *  @param depth  a maximum depth of traverse. Pass 0 for unlimited.
 *
 *  @return an array of UIView instances
 */
- (NSArray*)findAllViewsMatchingClassSuffix:(NSString*)suffix depth:(NSUInteger)depth;

@end
