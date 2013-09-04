//
//  UIViewController+TVOut.h
//  Singleton for TVOut and category for viewcontroller to quickly assign a UIView to the tv-out scren
//
//  Created by Daddycat on 9/4/13.
//  Copyright (c) 2013 chimou. All rights reserved.
//

#import <UIKit/UIKit.h>

// add setViewForTVOut to UIViewController
@interface UIViewController (TVOut)
-(void)setViewForTVOut:(UIView *)view;
@end


// delegates for TV Out
@protocol TVOutDelegate <NSObject>
@optional
-(void)screenDidConnectNotification:(id)sender;
-(void)screenDidDisconnectNotification:(id)sender;
-(void)screenModeDidChangeNotification:(id)sender;
@end

// TVOutManager class
@interface TVOutManager : NSObject
{
    UIWindow *tvoutWindow;
    UIView *rootView;
}
@property id <TVOutDelegate> delegate;
+ (TVOutManager *)sharedInstance;
- (void)setRootView:(UIView *)view;
@end

