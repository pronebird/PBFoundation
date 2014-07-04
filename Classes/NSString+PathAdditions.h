//
//  NSString+PathAdditions.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PathAdditions)

/**
 *  Get Application Support directory path with bundle name appended
 *
 *  @return a path to directory
 */
+ (NSString*)applicationSupportDirectoryWithBundleName; // application support directory + bundle name

/**
 *  Get Application Support directory path
 *
 *  @return a path to directory
 */
+ (NSString*)applicationSupportDirectory;

/**
 *  Get caches directory path
 *
 *  @return a path to directory
 */
+ (NSString*)cachesDirectory;

/**
 *  Get documents directory path
 *
 *  @return a path to directory
 */
+ (NSString*)documentDirectory;

/**
 *  Get temporary directory path
 *
 *  @return a path to directory
 */
+ (NSString*)temporaryDirectory;

/**
 *  Get a temporary file path with mask. where "X" replaced with random character.
 *  Example: video-XXXX.ext
 *
 *  @param templateString a filename with mask
 *
 *  @return a path to file
 */
+ (NSString*)temporaryFilePathWithTemplate:(NSString*)templateString;

@end
