//
//  UIView+Traverse.m
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIView+Traverse.h"

@implementation UIView (Traverse)

- (UIView*)findFirstViewWithClassPrefix:(NSString*)prefix {
	// First pass: check on current level
	for(UIView* view in self.subviews) {
		if([NSStringFromClass([view class]) hasPrefix:prefix]) {
			return view;
		}
	}
	
	// Second pass: go deeper
	for(UIView* view in self.subviews) {
		UIView* child = [view findFirstViewWithClassPrefix:prefix];
		if(child != nil) {
			return child;
		}
	}
	
	return nil;
}

- (UIView*)findFirstViewWithClassSuffix:(NSString*)suffix {
	// First pass: check on current level
	for(UIView* view in self.subviews) {
		if([NSStringFromClass([view class]) hasSuffix:suffix]) {
			return view;
		}
	}
	
	// Second pass: go deeper
	for(UIView* view in self.subviews) {
		UIView* child = [view findFirstViewWithClassSuffix:suffix];
		if(child != nil) {
			return child;
		}
	}
	
	return nil;
}

- (UIView*)findFirstViewMatchingClass:(Class)aClass depth:(NSUInteger)depth {
	if(depth > 1) { depth--; }
	
	// First pass: check if view exists on current level
	for(UIView* view in self.subviews) {
		if([view isKindOfClass:aClass]) {
			return view;
		}
		
	}
	
	// Second pass: go deeper
	if(depth > 1 || depth == 0) {
		for(UIView* view in self.subviews) {
			UIView* child = [view findFirstViewMatchingClass:aClass depth:depth];
			if(child) {
				return child;
			}
		}
	}
	
	return nil;
}

- (NSArray*)findAllViewsMatchingClass:(Class)aClass depth:(NSUInteger)depth {
	NSMutableArray* views = [NSMutableArray new];
	
	if(depth > 1) { depth--; }
	
	for(UIView* view in self.subviews) {
		if([view isKindOfClass:aClass]) {
			[views addObject:view];
			continue;
		}
		
		if(depth > 1 || depth == 0) {
			[views addObjectsFromArray:[view findAllViewsMatchingClass:aClass depth:depth]];
		}
	}
	
	return views;
}

- (NSArray*)findAllViewsMatchingClassSuffix:(NSString*)suffix depth:(NSUInteger)depth {
	NSMutableArray* views = [NSMutableArray new];
	
	if(depth > 1) { depth--; }
	
	for(UIView* view in self.subviews) {
		if([NSStringFromClass([view class]) hasSuffix:suffix]) {
			[views addObject:view];
			continue;
		}
		
		if(depth > 1 || depth == 0) {
			[views addObjectsFromArray:[view findAllViewsMatchingClassSuffix:suffix depth:depth]];
		}
	}
	
	return views;
}

@end
