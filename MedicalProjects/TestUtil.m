//
//  TestUtil.m
//  MedicalProjects
//
//  Created by Marco Velluto on 02/06/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "TestUtil.h"
#import "Util.h"

@implementation TestUtil

- (void)testSetVersion {
    int value = [Util setVersion];
    NSAssert(value != 0, @"1 - Valore uguale a 0");
}
@end
