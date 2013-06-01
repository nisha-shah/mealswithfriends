//
//  SCViewController.m
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "SCViewController.h"
#import "FrontViewControllerAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Meal.h"
#import "SCProtocols.h"




@implementation SCViewController
@synthesize userNameLabel;
@synthesize userProfilePic;
@synthesize mealImage,mealName;
@synthesize shareButton;
@synthesize mealsTextView;
@synthesize  ateThisButton;


//@synthesize sharingDetailsTableView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



/*
 - Display the selected meal .
 - Display the user name of logged in user .
 - Display the profile picture of logged in user
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mealsTextView.textColor=[UIColor redColor];
   // self.mealImage.hidden=YES;
    
    
    FrontViewControllerAppDelegate *appDelegate = (FrontViewControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
   // NSLog(@"APP DELEGATE VARIABLE %@",appDelegate.selectedItemMain);
    
    self.mealName.text=appDelegate.selectedItemMain;
    if([appDelegate.selectedItemMain isEqualToString:@"Brussels Sprouts"]){
        self.mealImage.image=[UIImage imageNamed:@"brussels.jpg"];
        self.mealsTextView.text=@"Organic brussels sprouts with olive oil aioli and espelette pepper";
    }else if([appDelegate.selectedItemMain isEqualToString:@"Banana Cake"]){
        self.mealImage.image=[UIImage imageNamed:@"bananaCake.jpg"];
        self.mealsTextView.text=@"Cake with whipped vanilla cream and caramel sauce";
    }else{
        self.mealImage.image=[UIImage imageNamed:@"burger.jpg"];
        self.mealsTextView.text=@"Beef burger with pork bacon, cave-aged gruyere, and organic mixed greens on a sesame seed bun. ";
    }
    
    
    
    self.navigationItem.title=@"Share Your Meal";
    
    self.navigationItem.hidesBackButton= YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Share"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(btnShareClicked:)];
    

    
        
    /*
     Once user has logged in, give user the option to "Logout".
     Placing the "Logout" button to the right item of navigation bar.
     */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(btnLogoutClicked:)];
    
    
    //table view
  //  mytableView.dataSource = self;
   // mytableView.delegate = self;
   
    //added for user Profile picture
   [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:SCSessionStateChangedNotification
     object:nil];
    
  //  self.ateThisButton.backgroundColor=[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(205.0/255.0) alpha:1];
   
   // [self.ateThisButton setBackgroundColor:[UIColor redColor]];
    
    self.ateThisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.ateThisButton.backgroundColor = [UIColor redColor];
    

    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}


- (IBAction)btnLogoutClicked:(id)sender {
    NSLog(@"Logout button clicked");
    [FBSession.activeSession closeAndClearTokenInformation];

}


//added for ProfilePicture 
- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
               
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userNameLabel.text = user.name;
               //  NSLog(@"User id is %@",user.id);
                 userProfilePic.profileID=user.id;
                 
                
             }
         }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

-(void)viewDidUnload{
[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}
//ProfilePicture end



/*
 Creates the Open Graph Action for sharing on user timeline
 */
- (IBAction)btnShareClicked:(id)sender {
        //for sharing
    
    NSLog(@"In share button");
 
    /* WORKING WITH URL FINE :
    
    NSURL* url = [NSURL URLWithString:@"https://developers.facebook.com/"];
    [FBDialogs presentShareDialogWithLink:url
                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      if(error) {
                                          NSLog(@"Error: %@", error.description);
                                      } else {
                                          NSLog(@"Success!");
                                      }
                                  }];
    */
    
    
         //action[@"meal"]=object1;
  //  [action setObject:object1 forKey:@"meal"];
   
  //  NSLog(@"actino is %@",action);
    
   /*
        
    NSDictionary* object = @{
                            @"fbsdk:create_object": @"YES",
                             @"type": @"fbmealswithfriends:meal",//@"meals-nisha:eat",
                             @"title": mealName.text,//@"Lamb Vindaloo",
                             @"mealimage": self.mealImage.image,//@"https://example.com/cooking-app/images/Lamb-Vindaloo.png",
                             @"url": @"http://facebooksampleapp.com/meals/meal.php?id=brisket",
                             @"mealname": self.mealName.text
                             };
    
   
    action[@"meal"]=object;
    
    */
    
 /* NOW  action[@"meal"] = @"544052918970950";
    
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"meals-nisha:eat"//@"fbmealswithfriends"//@"meals-nisha:eat"
                                 previewPropertyName:@"meal"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                 } else {
                                                     NSLog(@"Success!");
                                                 }
    NOW                                         }];
    */
    
       // Now create an Open Graph eat action with the meal, our location, and the people we were with.
    id<SCOGEatMealAction> action = (id<SCOGEatMealAction>)[FBGraphObject graphObject];
    
    if([self.mealName.text isEqualToString:@"Brussels Sprouts"])
    action[@"meal"] =@"114527235420691"; //BRUSSELS
    else if([self.mealName.text isEqualToString:@"Banana Cake"]){
     action[@"meal"] =@"450030578415741"; //CAke
    }else{
     action[@"meal"] =@"166807836819222"; //Burger
    }
    
       
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"meals-nisha:eat"
                                 previewPropertyName:@"meal"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Error"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK!"
                                                                       otherButtonTitles:nil]
                                                      show];

                                                     
                                                 } else {
                                                     NSLog(@"Success!");
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Posted Open Graph action successfully"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK !"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 }
                                                                                        }];

}


#pragma mark - UITableViewDataSource methods and related helpers


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
       // cell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        cell.textLabel.clipsToBounds = YES;
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.8 alpha:1];
       // cell.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
        cell.detailTextLabel.clipsToBounds = YES;
    }
    
    switch (indexPath.row) {
        case 0:
            
           // cell.textLabel.text = @"What are you eating?";
           // cell.detailTextLabel.text = @"Select one";
           // cell.imageView.image = self.mealImage.image;
            cell.backgroundView=[[UIImageView alloc] initWithImage:self.mealImage.image];
            //[UIImage imageNamed:@"action-eating.png"];
            break;
            
        case 1:
            cell.textLabel.text = @"Where are you?";
            cell.detailTextLabel.text = @"Select one";
            cell.imageView.image = [UIImage imageNamed:@"action-location.png"];
            break;
            
        case 2:
            cell.textLabel.text = @"With whom?";
            cell.detailTextLabel.text = @"Select friends";
            cell.imageView.image = [UIImage imageNamed:@"action-people.png"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
}

@end
