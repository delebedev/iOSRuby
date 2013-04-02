//
//  RubyEvaluator.h
//  iOSRuby
//
//  Created by Denis Lebedev on 24.3.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RubyEvaluator : NSObject

+ (instancetype)sharedInstance;

- (NSString *)evaluate:(NSString *)code;
- (void)addLoadPath:(NSString *)path;

@end
