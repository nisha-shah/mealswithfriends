//
//  MealsTableViewController.h
//  FBApi
//
//  Created by Nisha Shah on 5/16/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLoginViewController.h"
#import "SCViewController.h"

@interface MealsTableViewController : UITableViewController
{
    //contains list of meals.
    NSArray * mealList ;
   
}
@property(readwrite,nonatomic,retain)NSArray * mealList;
@property (strong, nonatomic) SCLoginViewController * loginViewController;
@property (strong, nonatomic) SCViewController * scViewController;



@end
