//
//  UIActionSheet+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static const void* kPBActionSheetBlocksDelegateKey = &kPBActionSheetBlocksDelegateKey;

#pragma mark - UIActionSheet delegate

@interface PBActionSheetBlocksDelegate : NSObject<UIActionSheetDelegate>

@property (weak) id realDelegate;

- (void)setBlock:(void(^)(void))block forButtonAtIndex:(NSInteger)index;
- (id)blockForButtonAtIndex:(NSInteger)index;

@end

@implementation PBActionSheetBlocksDelegate {
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	void(^block)(void) = [self blockForButtonAtIndex:buttonIndex];
	if(block != nil) {
		block();
	}
	
	if([self.realDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
		[self.realDelegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
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

#pragma mark - UIActionSheet+Blocks internals

@implementation UIActionSheet (BlocksInternal)

- (void)pb_setActionSheetBlocksDelegate:(PBActionSheetBlocksDelegate*)delegate {
	objc_setAssociatedObject(self, kPBActionSheetBlocksDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PBActionSheetBlocksDelegate*)pb_actionSheetBlocksDelegate {
	return objc_getAssociatedObject(self, kPBActionSheetBlocksDelegateKey);
}

@end

#pragma mark - UIActionSheet+Blocks

@implementation UIActionSheet (Blocks)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleMethod:@selector(initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:) withMethod:@selector(pb_initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:)];
	});
}

- (id)initWithTitle:(NSString*)title {
	return [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (id)pb_initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	PBActionSheetBlocksDelegate* blocksDelegate = [PBActionSheetBlocksDelegate new];
	blocksDelegate.realDelegate = delegate;
	
	// Pass first button title to trick UIActionSheet to setup firstOtherButtonIndex
	// The rest of buttons will be added later
	typeof(self) instance = [self pb_initWithTitle:title delegate:blocksDelegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles, nil];
	
	if(instance) {
		[instance pb_setActionSheetBlocksDelegate:blocksDelegate];
		
		if(otherButtonTitles) {
			va_list args;
			va_start(args, otherButtonTitles);
			NSString* arg;
			
			// First button title is already passed to initializer, we start from second
			while((arg = va_arg(args, NSString*)) != nil) {
				[instance addButtonWithTitle:arg];
			}
			va_end(args);
		}
		
		if(destructiveButtonTitle) {
			[instance addDestructiveButtonWithTitle:destructiveButtonTitle block:nil];
		}
		
		if(cancelButtonTitle) {
			[instance addCancelButtonWithTitle:cancelButtonTitle block:nil];
		}
	}
	
	return instance;
}

- (void)addButtonWithTitle:(NSString*)title block:(void(^)(void))block {
	NSInteger index = [self addButtonWithTitle:title];
	[[self pb_actionSheetBlocksDelegate] setBlock:block forButtonAtIndex:index];
}

- (void)addCancelButtonWithTitle:(NSString*)title block:(void(^)(void))block {
	NSInteger index = [self addButtonWithTitle:title];
	[self setCancelButtonIndex:index];
	[[self pb_actionSheetBlocksDelegate] setBlock:block forButtonAtIndex:index];
}

- (void)addDestructiveButtonWithTitle:(NSString*)title block:(void(^)(void))block {
	NSInteger index = [self addButtonWithTitle:title];
	[self setDestructiveButtonIndex:index];
	[[self pb_actionSheetBlocksDelegate] setBlock:block forButtonAtIndex:index];
}

@end
