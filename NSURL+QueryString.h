//
//  NSURL+QueryString.h
//  PBFoundation
//
//  Created by pronebird on 09/02/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryString)

/**
 *  Parse query string into dictionary
 *
 *  @return a dictionary with query string parameters as dictionary
 */
- (NSDictionary*)queryComponents;

@end
