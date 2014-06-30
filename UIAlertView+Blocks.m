//
//  UIAlertView+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static const void* kPBAlertViewBlocksDelegateKey = &kPBAlertViewBlocksDelegateKey;

#pragma mark - UIAlertView delegate

@interface PBAlertViewBlocksDelegate : NSObject<UIAlertViewDelegate>

@property (weak) id realDelegate;

- (void)setBlock:(void(^)(void))block forButtonAtIndex:(NSInteger)index;
- (id)blockForButtonAtIndex:(NSInteger)index;

@end

@implementation PBAlertViewBlocksDelegate {
	NSMutableDictionary* _buttonBlocks;
}

- (id)init {
	if(self = [super init]) {
		_buttonBlocks = [NSMutableDictionary new];
	}
	return self;
}

- (void)setBlock:(void(^)(void))block forButtonAtIndex:(NSInteger)index {
	if(block != nil) {
		_buttonBlocks[@(index)] = block;
	}
}

- (id)blockForButtonAtIndex:(NSInteger)index {
	return _buttonBlocks[@(index)];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	void(^block)(void) = [self blockForButtonAtIndex:buttonIndex];
	if(block != nil) {
		block();
	}
	
	// delegate event to realDelegate
	if([self.realDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
		[self.realDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
	}
}

- (BOOL)respondsToSelector:(SEL)aSelector {
	if([self.realDelegate respondsToSelector:aSelector]) {
		return YES;
	}
	
	return [super respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	if([self.realDelegate respondsToSelector:anInvocation.selector]) {
		[anInvocation invokeWithTarget:self.realDelegate];
	} else {
		[super forwardInvocation:anInvocation];
	}
}

@end

#pragma mark - UIAlertView+Blocks internals

@implementation UIAlertView (BlocksInternal)

- (void)pb_setAlertViewBlocksDelegate:(PBAlertViewBlocksDelegate*)delegate {
	objc_setAssociatedObject(self, kPBAlertViewBlocksDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PBAlertViewBlocksDelegate*)pb_alertViewBlocksDelegate {
	return objc_getAssociatedObject(self, kPBAlertViewBlocksDelegateKey);
}

@end

#pragma mark - UIAlertView+Blocks

@implementation UIAlertView (Blocks)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleMethod:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:) withMethod:@selector(pb_initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)];
	});
}

+ (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle {
	[[self alertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle] show];
}

+ (id)alertViewWithTitle:(NSString*)title message:(NSString*)message {
	return [[self alloc] initWithTitle:title message:message cancelButtonTitle:nil];
}

+ (id)alertViewWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle {
	return [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle];
}

- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle {
	return [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
}

- (id)pb_initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	PBAlertViewBlocksDelegate* blocksDelegate = [PBAlertViewBlocksDelegate new];
	blocksDelegate.realDelegate = delegate;
	
	typeof(self) instance = [self pb_initWithTitle:title message:message delegate:blocksDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];

	if(instance) {
		if(otherButtonTitles) {
			va_list args;
			va_start(args, otherButtonTitles);
			for(NSString* arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
				[instance addButtonWithTitle:arg];
			}
			va_end(args);
		}
		
		[instance pb_setAlertViewBlocksDelegate:blocksDelegate];
	}
	
	return instance;
}

- (void)addButtonWithTitle:(NSString*)title block:(void(^)(void))block {
	NSInteger index = [self addButtonWithTitle:title];
	[[self pb_alertViewBlocksDelegate] setBlock:block forButtonAtIndex:index];
}

- (void)addCancelButtonWithTitle:(NSString*)title block:(void(^)(void))block {
	NSInteger index = [self addButtonWithTitle:title];
	[[self pb_alertViewBlocksDelegate] setBlock:block forButtonAtIndex:index];
	[self setCancelButtonIndex:index];
}

@end
