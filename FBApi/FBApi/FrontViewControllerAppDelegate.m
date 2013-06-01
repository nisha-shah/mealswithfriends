//
//  FrontViewControllerAppDelegate.m
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

NSString *const SCSessionStateChangedNotification =
@"com.facebook.Scrumptious:SCSessionStateChangedNotification";

#import "FrontViewControllerAppDelegate.h"
#import "SCLoginViewController.h"
#import "SCViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FrontViewControllerAppDelegate ()

@end


@implementation FrontViewControllerAppDelegate

@synthesize navController = _navController;
@synthesize mainViewController = _mainViewController;
@synthesize selectedItemMain;

/*
 The first method called in AppDelegate is "didFinishLaunchingWithOptions".
 Initialise navigation controller with the first display page.
 Make navigatin controller as rootViewController
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.mainViewController = [[MealsTableViewController alloc]initWithNibName:@"MealsTableViewController" bundle:nil];
    
    
    self.navController = [[UINavigationController alloc]
                          initWithRootViewController:self.mainViewController];
    self.window.rootViewController = self.navController;
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
       [self openSession];
    }
   
    return YES;
}


- (void)showLoginView
{
    //landing screen for login.
  
    /*SCLoginViewController* loginViewController =
    [[SCLoginViewController alloc]initWithNibName:@"SCLoginViewController" bundle:nil];
    [self.navController pushViewController:loginViewController animated:NO];
    */
    
    [self.navController popToRootViewControllerAnimated:YES];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}


- (void)openSession
{
    
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];

}

/*
  Cases for sessin state changes . 
 */

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
           // NSLog(@"State is %@",state);
        case FBSessionStateOpen: //{
            /* REMOVED FOR DEPRECATED FUNCTIONS
             UIViewController *topViewController =
            [self.navController topViewController];
           if ([[topViewController modalViewController]
                 isKindOfClass:[SCLoginViewController class]])*/
            if([[self.navController topViewController] isKindOfClass:[SCLoginViewController class]])
            {
               /* [self.navController popViewControllerAnimated:YES];*/

                
                SCViewController* scViewController =
[[SCViewController alloc]initWithNibName:@"SCViewController" bundle:nil];
[self.navController pushViewController:scViewController animated:NO];
                
                
                
break;
                
            }
            
       // }
            
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
                       [self.navController popToRootViewControllerAnimated:NO];
            [FBSession.activeSession closeAndClearTokenInformation];
            [self showLoginView];
             break;
        
        default: NSLog(@"Default");break;
           
    }
    
    //added for  ProfilePicture
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SCSessionStateChangedNotification
     object:session];

  
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   [FBSession.activeSession handleDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
