//
//  Database.h
//  MedicalProjects
//
//  Created by Marco Velluto on 16/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

//-- Generali
static NSString * const KEY_DATA = @"Data";

//-- aWeight
static NSString * const KEY_WEIGHT = @"Peso";

//-- aGlicosic / aPressure
static NSString * const KEY_VALUE = @"Valore"; //Valore della Glicemia
static NSString * const KEY_TYPE = @"Tipo"; //Tipo di glicemia 1 - Basale / 2 - Preprandiale / 3 - Postprandiale

@protocol specipsDatabase <NSObject>

- (BOOL)deleteTableNamed:(NSString *)tableName; 
- (int)countOfDbFromTableNamed:(NSString *)tableName;
- (BOOL)deleteRowFromTableNamed:(NSString *)tableName withId:(int)index;

@end

typedef enum {
    BASALAE = 1,
    PREPRANDIALE = 2,
    POSTPRANDIALE = 3,
} TypeGliocos;

@interface Database : NSObject {
    
    sqlite3 *db;
}

- (BOOL)createTableWeight;
- (BOOL)createTablePressure;
- (BOOL)createTableGlicosic;

- (BOOL)insertWeight:(double)weight withData:(double)date;

- (BOOL)insertGlicosicBasale:(double)basale withDate:(double)date;
- (BOOL)insertGlicosicPreprandiale:(double)preprandiale withDate:(double)date;
- (BOOL)insertGlicosicPostprandiale:(double)postprandiale withDate:(double)date;

- (BOOL)insertPressureMin:(double)minValue withDate:(double)date;
- (BOOL)insertPressureMax:(double)maxValue withDate:(double)date;

- (int)countOfDbFromWeights;
- (int)countOfDbFromGliocosic;
- (int)countOfDbFromPressures;

- (BOOL)deleteTableWeights;
- (BOOL)deleteTableGliocosic;
- (BOOL)deleteTablePressure;

- (BOOL)deleteRowFromWeightWithIndex:(int)index;
- (BOOL)deleteRowFromGliocosicWithIndex:(int)index;
- (BOOL)deleteRowFromPressuresWithIndex:(int)index;

- (NSArray *)objectsFromWeight;
- (NSArray *)objectsFromPressures;
- (NSArray *)objectsFromGliocosic;

@end
