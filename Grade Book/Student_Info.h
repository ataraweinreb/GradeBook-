//
//  Student_Info.h
//  Grade Book
//
//  Created by Atara Weinreb on 10/2/19.
//  Copyright © 2019 Atara Weinreb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student_Info : NSObject

@property NSString *Name;
@property NSString *Address;
@property float Midterm;
@property float Final;
@property int Homework1;
@property int Homework2;
@property int Homework3;

@end

NS_ASSUME_NONNULL_END
