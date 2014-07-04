//
//  UIControl+Blocks.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Blocks)

/**
 *  Register block handler for events
 *
 *  @param events events mask
 *  @param block  a handler block
 *
 *  @return an opaque object that can be used to unregister block handler via removeTarget:
 */
- (id)addTargetForControlEvents:(UIControlEvents)events usingBlock:(void(^)(id sender))block;

/**
 *  Unregister block handler
 *
 *  @param target an opaque object returned by addTargetForControlEvents:usingBlock:
 */
- (void)removeTarget:(id)target;

@end
