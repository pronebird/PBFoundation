//
//  UIAlertView+NSError.m
//  PBFoundation
//
//  Created by pronebird on 8/30/13.
//  Copyright (c) 2013 pronebird. All rights reserved.
//

#import "UIAlertView+NSError.h"

@implementation UIAlertView (NSError)

+ (void)showWithError:(NSError*)error {
	[self showWithTitle:nil error:error];
}

+ (void)showWithTitle:(NSString*)title error:(NSError*)error {
	NSMutableString* message = [NSMutableString new];
	
	[message appendString: (error.localizedFailureReason ?: error.localizedDescription) ];
	
	if(error.localizedRecoverySuggestion != nil) {
		[message appendFormat:@" %@", error.localizedRecoverySuggestion];
	}
	
	[[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
}

@end
