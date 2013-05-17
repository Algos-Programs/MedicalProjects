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


@interface Database : NSObject {
    
    sqlite3 *db;
}

- (BOOL)createTableWeight;
- (BOOL)createTablePressure;
- (BOOL)createTableGlicosic;

- (BOOL)insertWeight:(double)weight withData:(double)date;

- (int)countOfDbFromWeights;
- (int)countOfDbFromTableNamed:(NSString *)tableName;

- (BOOL)deleteTableWeights;
- (BOOL)deleteTableNamed:(NSString *)tableName;

@end
