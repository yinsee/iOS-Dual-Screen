//
//  ViewController.m
//  dualscreentest
//
//  Created by Daddycat on 9/4/13.
//  Copyright (c) 2013 chimou. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+TVOut.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setview1:(id)sender {
    [self setViewForTVOut:self.subview1];

}

- (IBAction)setview2:(id)sender {
    [self setViewForTVOut:self.subview2];

}

- (IBAction)setview3:(id)sender {
    [self setViewForTVOut:self.subview3];

}
@end
