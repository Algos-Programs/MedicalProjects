//
//  DataType.h
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataType : NSObject

///Controlla il valore ricevuto da un UITextField
///@return true se è accettabile.
+ (BOOL)checkValue:(NSString *)value;

@end
