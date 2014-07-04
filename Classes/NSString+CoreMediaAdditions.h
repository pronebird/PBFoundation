//
//  NSString+CoreMediaAdditions.h
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@interface NSString (CoreMediaAdditions)

/**
 *  Format CMTime as HH:MM:SS interval string. Hour segment will be omitted if value is less than 1 hour.
 *
 *  @param time a CMTime value
 *
 *  @return a formatted time interval string
 */
+ (NSString*)stringWithCMTime:(CMTime)time;

@end
