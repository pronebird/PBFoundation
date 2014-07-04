//
//  NSObject+KindComparison.h
//  PBFoundation
//
//  Created by pronebird on 12/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KindComparison)

/**
 *  Check if object is kind of NSString
 *
 *  @return boolean flag
 */
- (BOOL)isKindOfString;

/**
 *  Check if object is kind of NSNumber
 *
 *  @return boolean flag
 */
- (BOOL)isKindOfNumber;

/**
 *  Check if object is kind of NSArray
 *
 *  @return boolean flag
 */
- (BOOL)isKindOfArray;

/**
 *  Check if object is kind of NSDictionary
 *
 *  @return boolean flag
 */
- (BOOL)isKindOfDictionary;

@end
