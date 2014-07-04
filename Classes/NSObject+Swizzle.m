//
//  NSObject+Swizzle.m
//  PBFoundation
//
//  Created by pronebird on 18/04/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)swizzleMethod:(SEL)original withMethod:(SEL)alternate {
	Method origMethod = class_getInstanceMethod(self, original);
	Method newMethod = class_getInstanceMethod(self, alternate);
	
	if(class_addMethod(self, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
		class_replaceMethod(self, alternate, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
	} else {
		method_exchangeImplementations(origMethod, newMethod);
	}
}

@end
