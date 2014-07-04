//
//  NSArray+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 07/05/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSArray+Blocks.h"

@implementation NSArray (Blocks)

- (NSArray*)mapUsingBlock:(id(^)(id object))block {
	NSParameterAssert(block);
	
	NSMutableArray* array = [NSMutableArray new];
	
	for(id object in self) {
		id result = block(object);
		
		NSAssert(result, @"The result of map block must not be nil.");
		
		[array addObject:result];
	}
	
	return array;
}

@end
