//
//  RubyEvaluator.m
//  iOSRuby
//
//  Created by Denis Lebedev on 24.3.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "RubyEvaluator.h"

#import "ruby.h"

#define NS_STR(x) [NSString stringWithCString:StringValuePtr(x) encoding:NSUTF8StringEncoding]
#define INSPECT_SCRIPT @"begin; (%@).inspect; rescue ScriptError, StandardError; 'Error: ' + ($! || 'exception raised'); end"

@implementation RubyEvaluator

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
		[self setupLibFiles];
#if !TARGET_IPHONE_SIMULATOR
		ruby_init();
		ruby_script("embedded");
        ruby_init_loadpath();
        VALUE r = rb_inspect(rb_gv_get("$:"));
        NSLog(@"PATH: %@", [NSString stringWithCString:StringValuePtr(r) encoding:NSUTF8StringEncoding]);
		[self addLoadPath:[[self documentsPath] stringByAppendingPathComponent:@"lib"]];
		Init_bigdecimal();
		Init_coverage();
		Init_dbm();
		Init_date_core();
		Init_digest();
		Init_md5();
		Init_rmd160();
		Init_sha1();
		Init_sha2();
		Init_etc();
		Init_fcntl();
		Init_fiber();
		Init_console();
		Init_nonblock();
		Init_wait();
		Init_strscan();
		Init_objspace();
		Init_pathname();
		Init_pty();
		//Init_sdbm();
		Init_stringio();
		Init_socket();
//DO NOT WORDK
		
		//Init_parser();
		//Init_generator();
		Init_encdb();
		Init_utf_16be();
		Init_utf_16le();
		Init_utf_32be();
		Init_utf_32le();
		rb_require("base64");
	
#endif
    }
    return self;
}

- (NSString *)evaluate:(NSString *)code {
#if TARGET_IPHONE_SIMULATOR
	return @"cannot eval on not TARGET_OS_IPHONE";
#else
	
	VALUE obj;
	int state;
	obj = rb_eval_string_protect([[NSString stringWithFormat:INSPECT_SCRIPT, code] UTF8String],
								 &state);
	NSString *result;
	if (state == 0) {
		result = [NSString stringWithCString:StringValuePtr(obj)
									encoding:NSUTF8StringEncoding];
	} else {
		result = @"exception raised";
		
		VALUE error = rb_inspect(rb_gv_get("$!"));
        NSString *rawError = NS_STR(error);
        NSLog(@"%@", rawError);
		
	}
	return [NSString stringWithFormat:@"%@ #=>\n%@", code, result];
#endif
}

- (void)addLoadPath:(NSString *)path {
#if !TARGET_IPHONE_SIMULATOR
	NSInteger state;
	NSString *script = [NSString stringWithFormat:@"$LOAD_PATH << '%@'", path];
    rb_eval_string_protect([script UTF8String], &state);
	
	VALUE r = rb_inspect(rb_gv_get("$LOAD_PATH"));
	NSLog(@"PATH: %@", [NSString stringWithCString:StringValuePtr(r) encoding:NSUTF8StringEncoding]);
	    
    if (state != 0) {
        [NSException raise:NSInvalidArgumentException format:@"Something went wrong"];
    }
#endif
}

#pragma mark - Private

- (void)setupLibFiles {
	NSString *libPath = [[self documentsPath] stringByAppendingPathComponent:@"lib"];
    NSString *source = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"lib"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:libPath isDirectory:NULL]) {
		NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:source toPath:libPath error:&error];
        assert(!error);
    }
}

- (NSString *)documentsPath {
	return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

@end
