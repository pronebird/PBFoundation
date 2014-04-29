//
//  NSObject+BlocksKeyValueObserving.m
//  PBFoundation
//
//  Created by pronebird on 22/04/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSObject+BlocksKeyValueObserving.h"
#import <objc/runtime.h>

#pragma mark - KeyValueBlockObserver helper

@interface PBKeyValueBlockObserver : NSObject

@property (strong) NSString* keyPath;
@property (assign) void* context;
@property (copy) void(^block)(NSString* keyPath, id object, NSDictionary* change, void* context);

- (id)initWithKeyPath:(NSString*)keyPath context:(void*)context usingBlock:(void(^)(NSString* keyPath, id object, NSDictionary* change, void* context))block;

@end

@implementation PBKeyValueBlockObserver

- (id)initWithKeyPath:(NSString*)keyPath context:(void*)context usingBlock:(void(^)(NSString* keyPath, id object, NSDictionary* change, void* context))block {
	if(self = [super init]) {
		self.keyPath = keyPath;
		self.context = context;
		self.block = block;
		
		DDLogDebug(@"-> PBKeyValueBlockObserver, keyPath = %@", keyPath);
	}
	return self;
}

- (void)dealloc {
	DDLogDebug(@"<- PBKeyValueBlockObserver, keyPath = %@", self.keyPath);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if([keyPath isEqualToString:self.keyPath] && context == self.context) {
		self.block(keyPath, object, change, context);
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end

#pragma mark - NSObject+BlocksKeyValueObserving internals

static const void* kPBKeyValueObserversKey = &kPBKeyValueObserversKey;

@implementation NSObject (BlocksKeyValueObservingInternal)

- (NSMutableArray*)pb_allKeyValueBlockObservers {
	NSMutableArray* allObservers = objc_getAssociatedObject(self, kPBKeyValueObserversKey);
	
	if(allObservers == nil) {
		allObservers = [NSMutableArray new];
		
		objc_setAssociatedObject(self, kPBKeyValueObserversKey, allObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	return allObservers;
}

- (void)pb_addKeyValueBlockObserver:(PBKeyValueBlockObserver*)observer {
	[[self pb_allKeyValueBlockObservers] addObject:observer];
}

- (void)pb_removeKeyValueBlockObserver:(PBKeyValueBlockObserver*)observer {
	[[self pb_allKeyValueBlockObservers] removeObject:observer];
}

@end

#pragma mark - NSObject+BlocksKeyValueObserving

@implementation NSObject (BlocksKeyValueObserving)

- (id)addObserverForKeyPath:(NSString*)keyPath options:(NSKeyValueObservingOptions)options context:(void*)context usingBlock:(void(^)(NSString* keyPath, id object, NSDictionary* change, void* context))block {
	NSParameterAssert(block != nil);
	
	PBKeyValueBlockObserver* observer = [[PBKeyValueBlockObserver alloc] initWithKeyPath:keyPath context:context usingBlock:block];
	
	[self pb_addKeyValueBlockObserver:observer];
	[self addObserver:observer forKeyPath:keyPath options:options context:context];
	
	return observer;
}

- (void)removeBlockObserver:(id)observer {
	NSParameterAssert([observer isKindOfClass:[PBKeyValueBlockObserver class]]);
	
	PBKeyValueBlockObserver* blockObserver = (PBKeyValueBlockObserver*)observer;
	
	[self removeObserver:observer forKeyPath:blockObserver.keyPath context:blockObserver.context];
	[self pb_removeKeyValueBlockObserver:observer];
}

@end
