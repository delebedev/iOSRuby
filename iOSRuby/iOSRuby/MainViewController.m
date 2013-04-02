//
//  MainViewController.m
//  iOSRuby
//
//  Created by Denis Lebedev on 24.3.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "MainViewController.h"
#import "RubyEvaluator.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.inputView becomeFirstResponder];
}

- (IBAction)onRunTap:(id)sender {
	NSString *s = [NSString stringWithFormat:@"%@\n%@",
				   [[RubyEvaluator sharedInstance] evaluate:self.inputView.text],
				   self.consoleView.text];
	self.consoleView.text = s;
	self.inputView.text = nil;
}

@end
