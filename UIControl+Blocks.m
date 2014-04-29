//
//  UIControl+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIControl+Blocks.h"
#import <objc/runtime.h>

#pragma mark - UIControl proxy target

@interface PBControlTarget : NSObject

@property (copy) void(^block)(id sender);

- (id)initWithBlock:(void(^)(id sender))block;
- (void)action:(id)sender;

@end

@implementation PBControlTarget

- (id)initWithBlock:(void(^)(id sender))block {
	if(self = [super init]) {
		self.block = block;
	}
	return self;
}

- (void)action:(id)sender {
	if(self.block != nil) {
		self.block(sender);
	}
}

@end

#pragma mark - UIControl+Blocks internals

const void* kPBControlTargetArrayKey = &kPBControlTargetArrayKey;

@implementation UIControl (BlocksInternal)

- (void)pb_addEventTargetForControlEvents:(PBControlTarget*)target {
	NSMutableArray* targets = objc_getAssociatedObject(self, kPBControlTargetArrayKey);
	
	if(targets == nil) {
		targets = [NSMutableArray new];
	}
	
	[targets addObject:target];
	
	objc_setAssociatedObject(self, kPBControlTargetArrayKey, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)pb_removeEventTargetForControlEvents:(PBControlTarget*)target {
	NSMutableArray* targets = objc_getAssociatedObject(self, kPBControlTargetArrayKey);
	
	if(targets != nil) {
		[targets removeObject:target];
		
		objc_setAssociatedObject(self, kPBControlTargetArrayKey, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
}

@end

#pragma mark - UIControl+Blocks

@implementation UIControl (Blocks)

- (id)addTargetForControlEvents:(UIControlEvents)events usingBlock:(void(^)(id sender))block {
	PBControlTarget* target = [[PBControlTarget alloc] initWithBlock:block];
	
	[self pb_addEventTargetForControlEvents:target];
	[self addTarget:target action:@selector(action:) forControlEvents:events];
	
	return target;
}

- (void)removeTarget:(id)target {
	[self removeTarget:target action:NULL forControlEvents:UIControlEventAllEvents];
	[self pb_removeEventTargetForControlEvents:target];
}

@end
