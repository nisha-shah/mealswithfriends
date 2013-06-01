//
//  SCViewController.h
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Meal.h"
#import "SCProtocols.h"


@interface SCViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>{
 IBOutlet UITableView *myTableView;
}
- (IBAction)btnLogoutClicked:(id)sender;

//added PP
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView * userProfilePic;
//added PP end

@property (strong, nonatomic) IBOutlet UIImageView *mealImage;
@property (strong, nonatomic) IBOutlet UILabel *mealName;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)btnShareClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *mealsTextView;
@property (strong, nonatomic) IBOutlet UIButton *ateThisButton;
//- (IBAction)btnAteThisClicked:(id)sender;


@end
