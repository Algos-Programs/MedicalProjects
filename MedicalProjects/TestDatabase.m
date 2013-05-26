//
//  TestDatabase.m
//  MedicalProjects
//
//  Created by Marco Velluto on 17/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "TestDatabase.h"
#import "Database.h"
#import "Database.m"

@implementation TestDatabase

Database *db;

- (void)setUp {
    db = [[Database alloc] init];
    [db deleteTableGliocosic];
    [db deleteTablePressure];
    [db deleteTableWeights];
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

- (void)testInsertGlicosic {
    [db createTableGlicosic];
    
    //-- Glicemia Basale
    BOOL returnValue = [db insertGlicosicBasale:123 withDate:32];
    NSAssert(returnValue, @"1 - Fallito inserimento glicemia");
    
    double value = [[[[db objectsFromGliocosic] objectAtIndex:0] valueForKey:KEY_VALUE] doubleValue];
    NSAssert(value == 123, @"2 - Valore glicemico non inserito corretamente");

    int type = [[[[db objectsFromGliocosic] objectAtIndex:0] valueForKey:KEY_TYPE] intValue];
    NSAssert(type == 1, @"3 - Tipo non inserito correttamente");

    double data = [[[[db objectsFromGliocosic] objectAtIndex:0] valueForKey:KEY_DATA] doubleValue];
    NSAssert(data == 32, @"4 - Data non inserita correttamente");

    
    //-- Glicemia Postprandiale
    BOOL returnValue1 = [db insertGlicosicPostprandiale:333 withDate:22];
    NSAssert(returnValue1, @"5 - Fallito inserimento glicemia");
    
    double value1 = [[[[db objectsFromGliocosic] objectAtIndex:1] valueForKey:KEY_VALUE] doubleValue];
    NSAssert(value1 == 333, @"6 - Valore glicemico non inserito corretamente");
    
    int type1 = [[[[db objectsFromGliocosic] objectAtIndex:1] valueForKey:KEY_TYPE] intValue];
    NSAssert(type1 == 3, @"7 - Tipo non inserito correttamente");

    double data1 = [[[[db objectsFromGliocosic] objectAtIndex:1] valueForKey:KEY_DATA] doubleValue];
    NSAssert(data1 == 22, @"8 - Data non inserita correttamente");
    
    //-- Glicemia Prepandiale
    BOOL returnValue2 = [db insertGlicosicPreprandiale:11 withDate:99];
    NSAssert(returnValue2, @"9 - Fallito inserimento glicemia");
    
    double value2 = [[[[db objectsFromGliocosic] objectAtIndex:2] valueForKey:KEY_VALUE] doubleValue];
    NSAssert(value2 == 11, @"10 - Valore glicemico non inserito corretamente");
    
    int type2 = [[[[db objectsFromGliocosic] objectAtIndex:2] valueForKey:KEY_TYPE] intValue];
    NSAssert(type2 == 2, @"11 - Tipo non inserito correttamente");
    
    double data2 = [[[[db objectsFromGliocosic] objectAtIndex:2] valueForKey:KEY_DATA] doubleValue];
    NSAssert(data2 == 99, @"12 - Data non inserita correttamente");

    
    //***** SENZA TABELLA ****
    [db deleteTableGliocosic];
    BOOL returnValue3 = [db insertGlicosicBasale:3434 withDate:333];
    NSAssert(returnValue3, @"13 - Fallito inserimento peso");
}

- (void)testInsertPressure {
    [db createTablePressure];
    
    //-- Pressione MAX
    BOOL returnValue = [db insertPressureMax:123 withDate:32];
    NSAssert(returnValue, @"1 - Fallito inserimento glicemia");
    
    double value = [[[[db objectsFromPressures] objectAtIndex:0] valueForKey:KEY_VALUE] doubleValue];
    NSAssert(value == 123, @"2 - Valore glicemico non inserito corretamente");
    
    int type = [[[[db objectsFromPressures] objectAtIndex:0] valueForKey:KEY_TYPE] intValue];
    NSAssert(type == 1, @"3 - Tipo non inserito correttamente");
    
    double data = [[[[db objectsFromPressures] objectAtIndex:0] valueForKey:KEY_DATA] doubleValue];
    NSAssert(data == 32, @"4 - Data non inserita correttamente");
    
    
    //-- Glicemia MIN
    BOOL returnValue1 = [db insertPressureMin:333 withDate:22];
    NSAssert(returnValue1, @"5 - Fallito inserimento glicemia");
    
    double value1 = [[[[db objectsFromPressures] objectAtIndex:1] valueForKey:KEY_VALUE] doubleValue];
    NSAssert(value1 == 333, @"6 - Valore glicemico non inserito corretamente");
    
    int type1 = [[[[db objectsFromPressures] objectAtIndex:1] valueForKey:KEY_TYPE] intValue];
    NSAssert(type1 == 2, @"7 - Tipo non inserito correttamente");
    
    double data1 = [[[[db objectsFromPressures] objectAtIndex:1] valueForKey:KEY_DATA] doubleValue];
    NSAssert(data1 == 22, @"8 - Data non inserita correttamente");
    
    
    //***** SENZA TABELLA ****
    [db deleteTableGliocosic];
    BOOL returnValue3 = [db insertGlicosicBasale:3434 withDate:333];
    NSAssert(returnValue3, @"13 - Fallito inserimento peso");
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
    [db createTableWeight];
    BOOL returnValue = [db deleteTableWeights];
    NSAssert(returnValue, @"Fallita calcellazione table Weighs");
    
    //-- Senza Tabella
    BOOL returnValue1 = [db deleteTableWeights];
    NSAssert(!returnValue1, @"Fallita calcellazione table Weighs");    
}

- (void)testDeleteTableGliocosic {
    [db createTableGlicosic];
    BOOL returnValue = [db deleteTableGliocosic];
    NSAssert(returnValue, @"Fallita calcellazione table Weighs");
    
    //-- Senza Tabella
    BOOL returnValue1 = [db deleteTableGliocosic];
    NSAssert(!returnValue1, @"Fallita calcellazione table Weighs");

}

- (void)testDeleteTablePressures {
    [db createTablePressure];
    BOOL returnValue = [db deleteTablePressure];
    NSAssert(returnValue, @"Fallita calcellazione table Weighs");
    
    //-- Senza Tabella
    BOOL returnValue1 = [db deleteTablePressure];
    NSAssert(!returnValue1, @"Fallita calcellazione table Weighs");
}


- (void)testDeleteRowFromWeight {
    [db createTableWeight];
    [db insertWeight:123 withData:3342];
    
    BOOL returnValue = [db deleteRowFromWeightWithIndex:1];
    int count1 = [db countOfDbFromWeights];
    NSAssert(returnValue, @"Impossibile cancellare elemento dalla tavola Weights");
    NSAssert(count1 == 0, @"Count non uguale a 0 nella tavola Weights");
    
    //Con elemento insesitente
    BOOL returnValue1 = [db deleteRowFromWeightWithIndex:0];
    NSAssert(returnValue1, @"1 - Impossibile cancellare elemento dalla tavola Weights");

    //Con tavola insesitente
    [db deleteTableWeights];
    BOOL returnValue2 = [db deleteRowFromWeightWithIndex:0];
    NSAssert(!returnValue2, @"2 - Impossibile cancellare elemento dalla tavola Weights");
}

- (void)testDeleteRowFromPressures {
    [db createTablePressure];
//    [db insertPressreWithPressMax:6564 withPresMin:46546 withDate:6546];
//    int count = [db countOfDbFromPressures];
//    NSAssert(count, @"Inserimento non riuscito");
//    
//    BOOL returnValue = [db deleteRowFromPressuresWithIndex:1];
//    int count1 = [db countOfDbFromPressures];
//    NSAssert(returnValue, @"Impossibile cancellare elemento dalla tavola Weights");
//    NSAssert(count1 == 0, @"Count non uguale a 0 nella tavola Weights");
//    
//    //Con elemento insesitente
//    BOOL returnValue1 = [db deleteRowFromPressuresWithIndex:0];
//    NSAssert(returnValue1, @"1 - Impossibile cancellare elemento dalla tavola Weights");
//    
//    //Con tavola insesitente
//    [db deleteTablePressure];
//    BOOL returnValue2 = [db deleteRowFromPressuresWithIndex:0];
//    NSAssert(!returnValue2, @"2 - Impossibile cancellare elemento dalla tavola Weights");
    //STFail(@"Da imlementare");
}

- (void)testDeleteRowFromGliocosic {
    [db createTableGlicosic];
//    [db insertGlicoicWithBasale:43424 withPrepardiale:68576 withPostPrandiale:567575 withDate:656757];
//    int count = [db countOfDbFromGliocosic];
//    NSAssert(count, @"Inserimento non riuscito");
//
//    BOOL returnValue = [db deleteRowFromGliocosicWithIndex:1];
//    int count1 = [db countOfDbFromGliocosic];
//    NSAssert(returnValue, @"Impossibile cancellare elemento dalla tavola Weights");
//    NSAssert(count1 == 0, @"Count non uguale a 0 nella tavola Weights");
//    
//    //Con elemento insesitente
//    BOOL returnValue1 = [db deleteRowFromGliocosicWithIndex:0];
//    NSAssert(returnValue1, @"1 - Impossibile cancellare elemento dalla tavola Weights");
//    
//    //Con tavola insesitente
//    [db deleteTableGliocosic];
//    BOOL returnValue2 = [db deleteRowFromGliocosicWithIndex:0];
//    NSAssert(!returnValue2, @"2 - Impossibile cancellare elemento dalla tavola Weights");
//
  //  STFail(@"Da implemetare");
}


- (void)testObjectsFromWeights {
    [db createTableWeight];
    [db insertWeight:3242 withData:765];
    NSArray *array = [db objectsFromWeight];
    NSAssert(array.count == 1, @"1 - Valori non presi dal DB");
    
    NSDictionary *dic = [array objectAtIndex:0];
    int index = [[dic valueForKey:@"id"] intValue];
    NSAssert(index == 1, @"2 - Index differente - %i", index);
    
    double weight = [[dic valueForKey:KEY_WEIGHT] doubleValue];
    NSAssert(weight == 3242, @"3 - weight %f != 324", weight);

    double data = [[dic valueForKey:KEY_DATA] doubleValue];
    NSAssert(data == 765, @"5 - data %f != 342", data);
    
    //--- DB close
}

- (void)testObjectsFromPressures {
//    [db createTablePressure];
//    [db insertPressreWithPressMax:324 withPresMin:3243 withDate:342];
//    NSArray *array = [db objectsFromPressures];
//    NSAssert(array.count == 1, @"1 - Valori non presi dal DB");
//    
//    NSDictionary *dic = [array objectAtIndex:0];
//    int index = [[dic valueForKey:@"id"] intValue];
//    NSAssert(index == 1, @"2 - Index differente - %i", index);
//    
//    double pressMax = [[dic valueForKey:KEY_PRE_MAX] doubleValue];
//    NSAssert(pressMax == 324, @"3 - Press Max %f != 324", pressMax);
//    
//    double pressMin = [[dic valueForKey:KEY_PRE_MIN] doubleValue];
//    NSAssert(pressMin == 3243, @"4 - Press MIn %f != 3243", pressMin);
//    
//    double data = [[dic valueForKey:KEY_DATA] doubleValue];
//    NSAssert(data == 342, @"5 - data %f != 342", data);
  //  STFail(@"Da implementare");
}

- (void)testObjectsFromGliocosic {
    [db createTableGlicosic];
    [db insertGlicosicBasale:123 withDate:333];
    NSArray *array = [db objectsFromGliocosic];
    NSAssert(array.count == 1, @"1 - Valori non presi dal DB");
    
    NSDictionary *dic = [array objectAtIndex:0];
    int index = [[dic valueForKey:@"id"] intValue];
    NSAssert(index == 1, @"2 - Index differente - %i", index);
    
    double gliBasale = [[dic valueForKey:KEY_DATA] doubleValue];
    NSAssert(gliBasale == 333, @"3 - Gli Basale %f != 333", gliBasale);
    
    double gliValue = [[dic valueForKey:KEY_VALUE] doubleValue];
    NSAssert(gliValue == 123, @"4 - Press MIn %f != 123", gliValue);
    
    double gliType = [[dic valueForKey:KEY_TYPE] doubleValue];
    NSAssert(gliType == 1, @"4 - Press MIn %f != 1", gliType);
}

@end



















