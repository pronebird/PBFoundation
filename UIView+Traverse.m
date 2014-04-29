//
//  UIView+Traverse.m
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIView+Traverse.h"

@implementation UIView (Traverse)

- (UIView*)findViewWithSuffix:(NSString*)suffix {
	for(UIView* view in self.subviews) {
		if([NSStringFromClass([view class]) hasSuffix:suffix]) {
			return view;
		}
		
		UIView* child = [view findViewWithSuffix:suffix];
		if(child != nil) {
			return child;
		}
	}
	
	return nil;
}

- (NSArray*)findViewsMatchingClass:(Class)aClass depth:(NSUInteger)depth {
	NSMutableArray* views = [NSMutableArray new];
	
	if(depth > 1) { depth--; }
	
	for(UIView* view in self.subviews) {
		if([view isKindOfClass:aClass]) {
			[views addObject:view];
			continue;
		}
		
		if(depth > 1 || depth == 0) {
			[views addObjectsFromArray:[view findViewsMatchingClass:aClass depth:depth]];
		}
	}
	
	return views;
}

@end
