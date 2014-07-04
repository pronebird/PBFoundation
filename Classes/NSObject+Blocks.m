//
//  NSObject+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSObject+Blocks.h"

@implementation NSObject (Blocks)

- (void)performAfterDelay:(NSTimeInterval)delayInSeconds block:(void(^)(void))block {
	NSParameterAssert(block != nil);
	
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^{
		block();
	});
}

@end
