//
//  UINavigationController+CompletionHandlers.h
//  PBFoundation
//
//  Created by pronebird on 25/04/14.
//  Copyright (c) 2014 Andrej Mihajlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Blocks)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

@end
