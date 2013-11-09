//
//  ViewController.m
//  AUIAutoGrowingTextView
//
//  Created by Adam on 11/9/13.
//  Copyright (c) 2013 adamsiton. All rights reserved.
//

#import "ViewController.h"
#import "AUIAutoGrowingTextView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet AUIAutoGrowingTextView *growingTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.growingTextView.maxHeight = 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
