//
//  UIViewController+TVOut.m
//  Singleton for TVOut and category for viewcontroller to quickly assign a UIView to the tv-out scren
//
//  Created by Daddycat on 9/4/13.
//  Copyright (c) 2013 chimou. All rights reserved.
//

#import "UIViewController+TVOut.h"

@implementation UIViewController (TVOut)

-(void)setViewForTVOut:(UIView *)view
{
    [[TVOutManager sharedInstance] setRootView:view];
}
@end


// TVOutManager class

@implementation TVOutManager

+ (TVOutManager *)sharedInstance
{
	static TVOutManager *sharedInstance;
    
	@synchronized(self)
	{
		if (!sharedInstance)
			sharedInstance = [[TVOutManager alloc] init];
		return sharedInstance;
	}
}

- (id) init
{
    self = [super init];
    if (self) {
		// can't imagine why, but just in case
		[[NSNotificationCenter defaultCenter] removeObserver: self];
        
		// catch screen-related notifications
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidConnectNotification:) name: UIScreenDidConnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidDisconnectNotification:) name: UIScreenDidDisconnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenModeDidChangeNotification:) name: UIScreenModeDidChangeNotification object: nil];
        
    }
    return self;
}

// this is the core of everything. see how it is done beautifully!
// all you need to do is tell us which View is for your TV Out. ;)
- (void)setRootView:(UIView *)view
{
	// you need to have a main window already open when you call start
	if ([[UIApplication sharedApplication] keyWindow] == nil) return;
    
    rootView = view;
	NSArray* screens = [UIScreen screens];
	if ([screens count] <= 1) {
		NSLog(@"TVOutManager: startTVOut failed (no external screens detected)");
		return;
	}
    
	if (tvoutWindow) {
		// tvoutWindow already exists, so this is a re-connected cable, or a mode chane
        tvoutWindow = nil;
	}
    
	if (!tvoutWindow) {
		CGSize max;
		max.width = 0;
		max.height = 0;
		UIScreenMode *maxScreenMode = nil;
		UIScreen *external = [[UIScreen screens] objectAtIndex: 1];
#if DEBUG
        NSLog(@"%@", [external availableModes]);
#endif
		for(int i = 0; i < [[external availableModes] count]; i++)
		{
			UIScreenMode *current = [[[[UIScreen screens] objectAtIndex:1] availableModes] objectAtIndex: i];
			if (current.size.width > max.width)
			{
				max = current.size;
				maxScreenMode = current;
			}
		}
		external.currentMode = maxScreenMode;
        
		tvoutWindow = [[UIWindow alloc] initWithFrame: CGRectMake(0,0, max.width, max.height)];
		tvoutWindow.userInteractionEnabled = NO;
		tvoutWindow.screen = external;
        
        [rootView setFrame:tvoutWindow.bounds];
        [tvoutWindow addSubview:rootView];
        
        rootView.hidden = NO;
		tvoutWindow.hidden = NO;

		tvoutWindow.backgroundColor = [UIColor whiteColor];
    }
}

-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}

// delegates caller
-(void)screenDidConnectNotification:(id)sender
{
#if DEBUG
    NSLog(@"screen did connect");
#endif
    
    // try to set the screen up when we connect
    if (rootView) [self setRootView:rootView];
    
    // if there is a delegate then notify it
    if ([self.delegate respondsToSelector:@selector(screenDidConnectNotification:)]) {
        [self.delegate screenDidConnectNotification:sender];
    }
}

-(void)screenDidDisconnectNotification:(id)sender
{
#if DEBUG
    NSLog(@"screen did disconnect");
#endif
    
    // if there is a delegate then notify it
    if ([self.delegate respondsToSelector:@selector(screenDidDisconnectNotification:)]) {
        [self.delegate screenDidDisconnectNotification:sender];
    }
    
}

-(void)screenModeDidChangeNotification:(id)sender
{
#if DEBUG
    NSLog(@"screen did change");
#endif
    
    // try to set the screen up when we re-connect
    if (rootView) [self setRootView:rootView];
    
    // if there is a delegate then notify it
    if ([self.delegate respondsToSelector:@selector(screenModeDidChangeNotification:)]) {
        [self.delegate screenModeDidChangeNotification:sender];
    }
}
@end
