//
//  NSObject+Swizzle.h
//  PBFoundation
//
//  Created by pronebird on 18/04/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleMethod:(SEL)original withMethod:(SEL)alternate;

@end
