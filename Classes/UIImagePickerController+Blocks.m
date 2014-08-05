//
//  UIImagePickerController+Blocks.m
//  PBFoundation
//
//  Created by pronebird on 26/04/14.
//  Copyright (c) 2014 Andrej Mihajlov. All rights reserved.
//

#import "UIImagePickerController+Blocks.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static const void* kBlocksDelegateKey = &kBlocksDelegateKey;

#pragma mark - UIImagePickerController delegate

@interface PBImagePickerControllerBlocksDelegate : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (copy) void(^didFinishPickingMediaWithInfoBlock)(UIImagePickerController* picker, NSDictionary* info);
@property (copy) void(^didCancelBlock)(UIImagePickerController* picker);
@property (copy) void(^willShowViewControllerBlock)(UINavigationController* navController, UIViewController* viewController, BOOL animated);
@property (copy) void(^didShowViewControllerBlock)(UINavigationController* navController, UIViewController* viewController, BOOL animated);

@end

@implementation PBImagePickerControllerBlocksDelegate

- (id)init {
	if(self = [super init]) {
		NSLog(@"%s", __PRETTY_FUNCTION__);
	}
	return self;
}

- (void)dealloc {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	if(self.didFinishPickingMediaWithInfoBlock) {
		self.didFinishPickingMediaWithInfoBlock(picker, info);
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	if(self.didCancelBlock) {
		self.didCancelBlock(picker);
	}
}

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated  {
    if(self.willShowViewControllerBlock != nil) {
		self.willShowViewControllerBlock(navigationController, viewController, animated);
    }
}

- (void)navigationController:(UINavigationController*)navigationController didShowViewController:(UIViewController*)viewController animated:(BOOL)animated  {
    if(self.didShowViewControllerBlock != nil) {
		self.didShowViewControllerBlock(navigationController, viewController, animated);
    }
}

@end

#pragma mark - UIImagePickerController+Blocks internal

@implementation UIImagePickerController (BlocksInternal)

- (void)pb_setImagePickerBlocksDelegate:(PBImagePickerControllerBlocksDelegate*)delegate {
	objc_setAssociatedObject(self, kBlocksDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PBImagePickerControllerBlocksDelegate*)pb_imagePickerBlocksDelegate {
	return objc_getAssociatedObject(self, kBlocksDelegateKey);
}

@end

#pragma mark - UIImagePickerController+Blocks

@implementation UIImagePickerController (Blocks)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleMethod:@selector(init) withMethod:@selector(pb_init)];
	});
}

- (id)pb_init {
	typeof(self) instance = [self pb_init];
	
	if(instance) {
		PBImagePickerControllerBlocksDelegate* blocksDelegate = [PBImagePickerControllerBlocksDelegate new];
		[self pb_setImagePickerBlocksDelegate:blocksDelegate];
		
		instance.delegate = blocksDelegate;
	}
	
	return instance;
}

- (void)setDidFinishPickingMediaWithInfoBlock:(void (^)(UIImagePickerController* picker, NSDictionary* info))block {
	[[self pb_imagePickerBlocksDelegate] setDidFinishPickingMediaWithInfoBlock:block];
}

- (void(^)(UIImagePickerController* picker, NSDictionary* info))didFinishPickingMediaWithInfoBlock {
	return [[self pb_imagePickerBlocksDelegate] didFinishPickingMediaWithInfoBlock];
}

- (void)setDidCancelBlock:(void (^)(UIImagePickerController* picker))block {
	[[self pb_imagePickerBlocksDelegate] setDidCancelBlock:block];
}

- (void(^)(UIImagePickerController* picker))didCancelBlock {
	return [[self pb_imagePickerBlocksDelegate] didCancelBlock];
}

- (void)setWillShowViewControllerBlock:(void (^)(UINavigationController *navController, UIViewController* viewController, BOOL animated))willShowViewControllerBlock {
	[[self pb_imagePickerBlocksDelegate] setWillShowViewControllerBlock:willShowViewControllerBlock];
}

- (void (^)(UINavigationController *navController, UIViewController* viewController, BOOL animated))willShowViewControllerBlock {
	return [[self pb_imagePickerBlocksDelegate] willShowViewControllerBlock];
}

- (void)setDidShowViewControllerBlock:(void (^)(UINavigationController *navController, UIViewController* viewController, BOOL animated))didShowViewControllerBlock {
	[[self pb_imagePickerBlocksDelegate] setDidShowViewControllerBlock:didShowViewControllerBlock];
}

- (void (^)(UINavigationController *navController, UIViewController* viewController, BOOL animated))didShowViewControllerBlock {
	return [[self pb_imagePickerBlocksDelegate] didShowViewControllerBlock];
}

@end
