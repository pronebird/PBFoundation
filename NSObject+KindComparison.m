//
//  NSObject+KindComparison.m
//  PBFoundation
//
//  Created by pronebird on 12/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSObject+KindComparison.h"

@implementation NSObject (KindComparison)

- (BOOL)isKindOfString {
	return [self isKindOfClass:[NSString class]];
}

- (BOOL)isKindOfNumber {
	return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isKindOfArray {
	return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isKindOfDictionary {
	return [self isKindOfClass:[NSDictionary class]];
}

@end
