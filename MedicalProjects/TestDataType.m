//
//  TestDataType.m
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "TestDataType.h"
#import "DataType.h"

@implementation TestDataType

- (void)setUp {
    
}

- (void)testCheckValue {
    //-- Stringa - NON accettabile.
    NSString *str = @"CIAO";
    BOOL returnValue  = [DataType checkValue:str];
    NSAssert(!returnValue, @"1 - Ciao accettato come valore");
    
    NSString *str1 = [[NSString alloc] init];
    BOOL returnValue1 = [DataType checkValue:str1];
    NSAssert(!returnValue1, @"2 - Init accettato come valore");
    
    NSString *str2 = @"";
    BOOL returnValue2 = [DataType checkValue:str2];
    NSAssert(!returnValue2, @"3 - Stringa vuota accettata come valore");
    
    //-- Valori da accettare.
    NSString *str3 = @"123";
    BOOL returnValue3 = [DataType checkValue:str3];
    NSAssert(returnValue3, @"4 - %f NON accetto come valore", [str3 doubleValue]);
        
    NSString *str5 = @"123.98";
    BOOL returnValue5 = [DataType checkValue:str5];
    NSAssert(returnValue5, @"6 - %f NON accetto come valore", [str5 doubleValue]);
    
    NSString *str6 = @"123,943";
    BOOL returnValue6 = [DataType checkValue:str6];
    NSAssert(returnValue6, @"7 - %f NON accetto come valore", [str6 doubleValue]);
    
    //-- Valori da NON accettare.
    NSString *str4 = @"0";
    BOOL returnValue4 = [DataType checkValue:str4];
    NSAssert(!returnValue4, @"5 - %f NON accetto come valore", [str4 doubleValue]);

    NSString *str7 = @"-0";
    BOOL returnValue7 = [DataType checkValue:str7];
    NSAssert(!returnValue7, @"8 - %f NON accetto come valore", [str7 doubleValue]);
    
    NSString *str8 = @"-123";
    BOOL returnValue8 = [DataType checkValue:str8];
    NSAssert(!returnValue8, @"9 - %f NON accetto come valore", [str8 doubleValue]);
    
    NSString *str9 = @"320";
    BOOL returnValue9 = [DataType checkValue:str9];
    NSAssert(!returnValue9, @"10 - %f NON accetto come valore", [str9 doubleValue]);
    
    NSString *str10 = @"aa320";
    BOOL returnValue10 = [DataType checkValue:str10];
    NSAssert(!returnValue10, @"11 - %f NON accetto come valore", [str10 doubleValue]);
    
    NSString *str11 = @"320ewf";
    BOOL returnValue11 = [DataType checkValue:str11];
    NSAssert(!returnValue11, @"12 - %f NON accetto come valore", [str11 doubleValue]);

    NSString *str12 = @"20ewf";
    BOOL returnValue12 = [DataType checkValue:str12];
    NSAssert(!returnValue12, @"13 - %f NON accetto come valore", [str12 doubleValue]);
    
    NSString *str13 = @"qwe20e";
    BOOL returnValue13 = [DataType checkValue:str13];
    NSAssert(!returnValue13, @"14 - %f NON accetto come valore", [str13 doubleValue]);


}

@end
