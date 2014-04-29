//
//  UIGestureRecognizer+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIGestureRecognizer+Blocks.h"
#import <objc/runtime.h>

const void* kPBGestureRecognizerBlockKey = &kPBGestureRecognizerBlockKey;

#pragma mark - UIGestureRecognizer+Blocks internals

@implementation UIGestureRecognizer (BlocksInternal)

- (void)pb_handleGesture:(UIGestureRecognizer*)gestureRecognizer {
	void(^block)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state) = [self pb_gestureRecognizerHandlerBlock];
	if(block != nil) {
		block(self, self.state);
	}
}

- (void)pb_setGestureRecognizerHandlerBlock:(void(^)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state))block {
	objc_setAssociatedObject(self, kPBGestureRecognizerBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)pb_gestureRecognizerHandlerBlock {
	return objc_getAssociatedObject(self, kPBGestureRecognizerBlockKey);
}

@end

#pragma mark - UIGestureRecognizer+Blocks

@implementation UIGestureRecognizer (Blocks)

+ (id)gestureRecognizerWithBlock:(void(^)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state))block {
	return [[self alloc] initWithBlock:block];
}

- (id)initWithBlock:(void(^)(UIGestureRecognizer* recognizer, UIGestureRecognizerState state))block {
	if(self = [self initWithTarget:self action:@selector(pb_handleGesture:)]) {
		[self pb_setGestureRecognizerHandlerBlock:block];
	}
	return self;
}

@end
