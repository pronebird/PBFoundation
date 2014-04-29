//
//  NSObject+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Blocks)

/**
 *  Perform block after delay
 *
 *  @param block          a block to perform
 *  @param delayInSeconds a delay in seconds
 */
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delayInSeconds;

@end
