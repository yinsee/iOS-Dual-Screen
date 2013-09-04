//
//  ViewController.h
//  dualscreentest
//
//  Created by Daddycat on 9/4/13.
//  Copyright (c) 2013 chimou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *subview1;
@property (strong, nonatomic) IBOutlet UIView *subview2;
@property (strong, nonatomic) IBOutlet UIView *subview3;
- (IBAction)setview1:(id)sender;
- (IBAction)setview2:(id)sender;
- (IBAction)setview3:(id)sender;

@end
