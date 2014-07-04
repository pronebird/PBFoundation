//
//  NSString+PathAdditions.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSString+PathAdditions.h"

@implementation NSString (PathAdditions)

+ (NSString*)applicationSupportDirectoryWithBundleName {
	NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(__bridge NSString *)kCFBundleNameKey];
	return [[self applicationSupportDirectory] stringByAppendingPathComponent:applicationName];
}

+ (NSString*)applicationSupportDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString*)cachesDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString*)documentDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString*)temporaryDirectory {
	return NSTemporaryDirectory();
}

+ (NSString*)temporaryFilePathWithTemplate:(NSString*)templateString {
	NSString* basename = [[templateString lastPathComponent] stringByDeletingPathExtension];
	NSString* ext = [templateString pathExtension];
	NSString* temporaryPath = [[[self temporaryDirectory] stringByAppendingPathComponent:basename] stringByAppendingPathExtension:ext];
	
	const char* pathBuf = [temporaryPath cStringUsingEncoding:NSASCIIStringEncoding];
	assert(pathBuf != NULL);
	
	char* templateBuf = strdup(pathBuf);
	assert(templateBuf != NULL);
	
	int suffixLength = 0;
	if([ext length] > 0) {
		suffixLength = (int)([ext length] + 1);
	}
	
	if(mkstemps(templateBuf, suffixLength) != -1) {
		temporaryPath = [NSString stringWithCString:templateBuf encoding:NSASCIIStringEncoding];
	}
	
	free(templateBuf);
	
	return temporaryPath;
}

@end
