//
//  Util.h
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PESO = 1,
    GLICEMIA = 2,
    PRESSIONE = 3,
}TypeApp;

@interface Util : NSObject

+ (int)version;

+ (NSString *)data:(NSTimeInterval *)timeInterval;

@end
