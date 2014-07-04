//
//  UIImagePickerController+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 26/04/14.
//  Copyright (c) 2014 Andrej Mihajlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (Blocks)

@property (nonatomic, copy) void(^didFinishPickingMediaWithInfoBlock)(UIImagePickerController* picker, NSDictionary* info);
@property (nonatomic, copy) void(^didCancelBlock)(UIImagePickerController* picker);
@property (nonatomic, copy) void(^willShowViewControllerBlock)(UINavigationController* navController, UIViewController* viewController, BOOL animated);
@property (nonatomic, copy) void(^didShowViewControllerBlock)(UINavigationController* navController, UIViewController* viewController, BOOL animated);

@end
