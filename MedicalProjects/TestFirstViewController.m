//
//  TestFirstViewController.m
//  MedicalProjects
//
//  Created by Marco Velluto on 18/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "TestFirstViewController.h"
#import "FirstViewController.m"

@implementation TestFirstViewController

FirstViewController *fvc;

- (void)setUp {
    fvc = [[FirstViewController alloc] init];
}

- (void)testSetVersion {

    int setVarsion = [fvc setVersion];
    NSAssert(setVarsion != -1, @"NON FUNzionA ANCoRA");
}

@end