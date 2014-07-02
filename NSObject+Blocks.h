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
 *  @param delayInSeconds a delay in seconds
 *  @param block          a block to perform
 */
- (void)performAfterDelay:(NSTimeInterval)delayInSeconds block:(void(^)(void))block;

@end
