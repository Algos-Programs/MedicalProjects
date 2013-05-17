//
//  TestDatabase.m
//  MedicalProjects
//
//  Created by Marco Velluto on 17/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "TestDatabase.h"
#import "Database.h"

@implementation TestDatabase

Database *db;

- (void)setUp {
    db = [[Database alloc] init];
}


- (void)testCreateTableWeight {
    BOOL createTable = [db createTableWeight];
    NSAssert(createTable, @"Impossibile creare tablella Pesi.");
}

- (void)testCreateTablePressure {
    BOOL createTable = [db createTablePressure];
    NSAssert(createTable, @"Impossibile creare tablella Pressioni.");
}

- (void)testCreateTableGlicosic {
    BOOL createTable = [db createTableGlicosic];
    NSAssert(createTable, @"Impossibile creare tablella Glicemia.");
}


- (void)testInsertWeigh {
    BOOL returnValue = [db insertWeight:12.0 withData:928324];
    NSAssert(returnValue, @"Fallito inserimento peso.");
    
    //-- Senza Tabella.
    [db deleteTableWeights];
    BOOL returnValue1 = [db insertWeight:4324 withData:34];
    NSAssert(returnValue1, @"Fallito inserimento peso 1");
}

- (void)testInsertGlicoic {
    BOOL returnValue = [db insertGlicoicWithBasale:3424 withPrepardiale:342 withPostPrandiale:34234 withDate:3e34];
    NSAssert(returnValue, @"Fallito inserimento glicemia");
    
    //-- Senza Tabella
    [db deleteTableGliocosic];
    BOOL returnValue1 = [db insertWeight:4324 withData:34];
    NSAssert(returnValue1, @"Fallito inserimento peso 1");
}

- (void)testInsertPressure {
    BOOL returnValue = [db insertPressreWithPressMax:324324 withPresMin:3423 withDate:432432];
    NSAssert(returnValue, @"Fallito inserimento glicemia");
    
    //-- Senza Tabella
    [db deleteTablePressure];
    BOOL returnValue1 = [db insertPressreWithPressMax:324324 withPresMin:3423 withDate:432432];
    NSAssert(returnValue1, @"Fallito inserimento peso 1");

}


- (void)testCountDb {
    //-- Tabella Vuota
    [db deleteTableWeights];
    int count = [db countOfDbFromWeights];
    NSAssert(count == 0, @"Count DB Falied");
    
    //-- Tabella 1 Elemento
    [db insertWeight:123.4 withData:34];
    int count1 = [db countOfDbFromWeights];
    NSAssert(count1 == 1, @"Count DB Falied");

    //-- Senza tabella
    [db deleteTableWeights];
    int count2 = [db countOfDbFromWeights];
    NSAssert(count2 == 0, @"Count DB Falied");
}


- (void)testDeleteTableWeights {
    BOOL returnValue = [db deleteTableWeights];
    NSAssert(returnValue, @"Fallita calcellazione table Weighs");
    
    //-- Senza Tabella
    BOOL returnValue1 = [db deleteTableWeights];
    NSAssert(!returnValue1, @"Fallita calcellazione table Weighs");    
}

- (void)testDeleteTableGliocosic {
    
    BOOL returnValue = [db deleteTableGliocosic];
    NSAssert(returnValue, @"Fallita calcellazione table Weighs");
    
    //-- Senza Tabella
    BOOL returnValue1 = [db deleteTableGliocosic];
    NSAssert(!returnValue1, @"Fallita calcellazione table Weighs");

}


@end
