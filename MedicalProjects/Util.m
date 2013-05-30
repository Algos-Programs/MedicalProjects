//
//  Util.m
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (int)setVersion {
#warning Implementare.
    //Controllo del target - Inserischi qui i dati Guido. 
    return 1;
}

+ (NSString *)data:(NSTimeInterval *)timeInterval {
    NSDate *currDate = [[NSDate alloc] initWithTimeIntervalSince1970:*timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-YY HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    return dateString;
}

@end
