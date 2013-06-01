//
//  FrontViewControllerAppDelegate.h
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

extern NSString *const SCSessionStateChangedNotification;

#import <UIKit/UIKit.h>
#import "SCViewController.h"
#import "MealsTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FrontViewControllerAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *selectedItemMain;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MealsTableViewController *mainViewController;
@property(readwrite,nonatomic)NSString *selectedItemMain;
@property (strong, nonatomic) UINavigationController* navController;

- (void)openSession;

@end
