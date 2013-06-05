//
//  Util.m
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "Util.h"

@implementation Util

/**
 @return 0 - if target UNRECOGNIZED 
 @return 1 - if target is aWeight
 @return 2 - if target is aGlucose
 @return 3 - if target is aPressure
 
 */
+ (int)version {
int returnValue = 0;
    
#ifdef WEIGHT_VERSION
    returnValue = 1;
#endif
    
#ifdef GLUCOSE_VERSION
    returnValue = 2;
#endif

#ifdef PRESSURE_VERSION
    returnValue = 3;
#endif

    return returnValue;
}

/**
 Elabora la data passata in TimeInterval
 @return String - La data in dd-MM-YY HH:mm come stringa.
 */
+ (NSString *)data:(NSTimeInterval *)timeInterval {
    NSDate *currDate = [[NSDate alloc] initWithTimeIntervalSince1970:*timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-YY HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    return dateString;
}

@end
