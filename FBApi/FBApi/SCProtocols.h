//
//  SCProtocols.h
//  FBApi
//
//  Created by Nisha Shah on 5/23/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol SCOGMeal<FBGraphObject>

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *url;

@end

@protocol SCOGEatMealAction<FBOpenGraphAction>

@property (retain, nonatomic) id<SCOGMeal> meal;

@end