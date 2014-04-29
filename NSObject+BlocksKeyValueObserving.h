//
//  NSObject+BlocksKeyValueObserving.h
//  PBFoundation
//
//  Created by pronebird on 22/04/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BlocksKeyValueObserving)

/**
 *  Register a key-value observer with block handler
 *
 *  @param keyPath a key path
 *  @param options options
 *  @param context a context
 *  @param block   a handler block
 *
 *  @return an opaque object that can be used to unregister observer
 */
- (id)addObserverForKeyPath:(NSString*)keyPath options:(NSKeyValueObservingOptions)options context:(void*)context usingBlock:(void(^)(NSString* keyPath, id object, NSDictionary* change, void* context))block;

/**
 *  Unregister a key-value observer
 *
 *  @param observer an opaque object received via addObserverForKeyPath:options:context:usingBlock:
 */
- (void)removeBlockObserver:(id)observer;

@end
