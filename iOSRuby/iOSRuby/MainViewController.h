//
//  MainViewController.h
//  iOSRuby
//
//  Created by Denis Lebedev on 24.3.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

- (IBAction)onRunTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (weak, nonatomic) IBOutlet UITextView *consoleView;

@end
