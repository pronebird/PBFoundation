//
//  UIActionSheet+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Blocks)

- (id)initWithTitle:(NSString*)title;
- (void)addButtonWithTitle:(NSString*)title block:(void(^)(void))block;
- (void)addCancelButtonWithTitle:(NSString*)title block:(void(^)(void))block;
- (void)addDestructiveButtonWithTitle:(NSString*)title block:(void(^)(void))block;

@end
