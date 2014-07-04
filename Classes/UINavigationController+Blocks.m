//
//  UINavigationController+CompletionHandlers.m
//  PBFoundation
//
//  Created by pronebird on 25/04/14.
//  Copyright (c) 2014 Andrej Mihajlov. All rights reserved.
//

#import "UINavigationController+Blocks.h"

@implementation UINavigationController (Blocks)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion {
	[CATransaction begin];
	[CATransaction setCompletionBlock:^{
		if(completion)
			completion();
	}];
	
	[self pushViewController:viewController animated:animated];
	
	[CATransaction commit];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion {
	[CATransaction begin];
	[CATransaction setCompletionBlock:^{
		if(completion) {
			completion();
		}
	}];
	
	UIViewController* popViewController = [self popViewControllerAnimated:animated];
	
	[CATransaction commit];
	
	return popViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion {
	[CATransaction begin];
	[CATransaction setCompletionBlock:^{
		if(completion) {
			completion();
		}
	}];
	
	NSArray* popViewControllers = [self popToViewController:viewController animated:animated];
	
	[CATransaction commit];
	
	return popViewControllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion {
	[CATransaction begin];
	[CATransaction setCompletionBlock:^{
		if(completion) {
			completion();
		}
	}];
	
	NSArray* popViewControllers = [self popToRootViewControllerAnimated:animated];
	
	[CATransaction commit];
	
	return popViewControllers;
}

@end
