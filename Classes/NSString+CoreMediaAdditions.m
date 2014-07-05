//
//  NSString+CoreMediaAdditions.m
//  PBFoundation
//
//  Created by pronebird on 23/01/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSString+CoreMediaAdditions.h"

@implementation NSString (CoreMediaAdditions)

+ (NSString*)stringWithCMTime:(CMTime)time {
	long totalSeconds = (long)CMTimeGetSeconds(time);
	
	long hours = totalSeconds / 3600;
	long minutes = totalSeconds % 3600 / 60;
	long seconds = totalSeconds % 3600 % 60;
	
	if(hours > 0) {
		return [NSString stringWithFormat:@"%ld:%02ld:%02ld", hours, minutes, seconds];
	}
	
	return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
}

@end
