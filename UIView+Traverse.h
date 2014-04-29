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
 *  Find views matching class name suffix
 *
 *  @param suffix a suffix to match against
 *
 *  @return an UIView instance
 */
- (UIView*)findViewWithSuffix:(NSString*)suffix;

/**
 *  Find views matching class
 *
 *  @param aClass a Class object to match against
 *  @param depth  a maximum depth of traverse. Pass 0 for unlimited.
 *
 *  @return an array of UIView instances
 */
- (NSArray*)findViewsMatchingClass:(Class)aClass depth:(NSUInteger)depth;

@end
