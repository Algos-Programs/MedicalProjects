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

//-- aPressure
static NSString * const KEY_PRE_MAX = @"Press_Max"; //Pressione Sistolica.
static NSString * const KEY_PRE_MIN = @"Press_min"; //Pressione Diastolica.

//-- aGlicosic
static NSString * const KEY_GLI_BASALE = @"Glic_Basale"; //Glicemia Basale - Lontano dai pasti.
static NSString * const KEY_GLI_PREPRANDIALE = @"Glic_Prepandiale"; //Glicemia Prepandiale - Prima dei pasti.
static NSString * const KEY_GLI_POSTPRANDIALE = @"Glic_Postprandiale"; //Glicemia Postprandiale - Dopo dai pasti.

@protocol specipsDatabase <NSObject>

- (BOOL)deleteTableNamed:(NSString *)tableName; 
- (int)countOfDbFromTableNamed:(NSString *)tableName;
- (BOOL)deleteRowFromTableNamed:(NSString *)tableName withId:(int)index;

@end

@interface Database : NSObject {
    
    sqlite3 *db;
}

- (BOOL)createTableWeight;
- (BOOL)createTablePressure;
- (BOOL)createTableGlicosic;

- (BOOL)insertWeight:(double)weight withData:(double)date;
- (BOOL)insertGlicoicWithBasale:(double)basale withPrepardiale:(double)prepard withPostPrandiale:(double)post withDate:(double)date;
- (BOOL)insertPressreWithPressMax:(double)max withPresMin:(double)pressMin withDate:(double)date;

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
