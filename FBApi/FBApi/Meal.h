//
//  Meal.h
//  FBApi
//
//  Created by Nisha Shah on 5/22/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject
{
    NSString *mName;
    NSString *mDescription;
    UIImage *mImage;
}

@property(readwrite,nonatomic)NSString *mName;
@property(readwrite,nonatomic)NSString *mDescription;
@property(readwrite,nonatomic)UIImage *mImage;
@end
