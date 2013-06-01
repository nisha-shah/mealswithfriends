//
//  SCLoginViewController.h
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *mealImageView;
@property (strong, nonatomic) IBOutlet UITextView *mealTextView;
@property (strong, nonatomic) IBOutlet UILabel *lblMealName;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)btnShareClick:(id)sender;
-(void)loginFailed;


@end
