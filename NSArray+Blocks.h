//
//  NSArray+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 07/05/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Blocks)

- (NSArray*)mapUsingBlock:(id(^)(id object))block;

@end
