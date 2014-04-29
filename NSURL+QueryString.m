//
//  NSURL+QueryString.m
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "NSURL+QueryString.h"

@implementation NSURL (QueryString)

- (NSDictionary*)queryComponents {
	NSArray* parameters = [self.query componentsSeparatedByString:@"&"];
	NSMutableDictionary* result = [NSMutableDictionary new];
	
	for(NSString* str in parameters) {
		NSArray* pair = [str componentsSeparatedByString:@"="];
		if([pair count] > 1) {
			result[pair[0]] = pair[1];
		}
	}
	
	return result;
}

@end
