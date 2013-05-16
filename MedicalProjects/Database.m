//
//  Database.m
//  MedicalProjects
//
//  Created by Marco Velluto on 16/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "Database.h"
#import <sqlite3.h>

static NSString * const TABLE_NAME_WEIGHTS = @"Pesi";
static NSString * const TABLE_NAME_PRESSURES = @"Pressioni";
static NSString * const TABLE_NAME_GLIOCOSIC = @"Glicemia";

@implementation Database


- (NSString *) filePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"Database.sql"];
}

- (void) openDB {
    
    //-- Create Database --
    if (sqlite3_open([[self filePath] UTF8String], &(db)) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"**** ERROR: Fallita apertura DB");
    }
}

//************************************
#pragma mark - Creazione Tabelle
//************************************

/**
 Crea tablella dei PESI
 */
- (BOOL)createTableWeight {
    char *err;
    NSString *query = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                        "INTEGER PRIMARY KEY, '%@' REAL, '%@' REAL);",
                        TABLE_NAME_WEIGHTS,
                        @"id",
                        KEY_DATA, //1...
                        KEY_WEIGHT];
    [self openDB];
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"*****ERRORE:Table %@ falied create. - %s", TABLE_NAME_WEIGHTS, err);
        return false;
    }
    return true;
}

/**
 Crea tablella della PRESSIONE
 */
- (BOOL)createTablePressure {
    char *err;
    NSString *query = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                       "INTEGER PRIMARY KEY, '%@' REAL, '%@' REAL, '%@' REAL);",
                       TABLE_NAME_PRESSURES,
                       @"id",
                       KEY_DATA, //1...
                       KEY_PRE_MAX,
                       KEY_PRE_MIN];
    [self openDB];
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"*****ERRORE:Table %@ falied create. - %s", TABLE_NAME_WEIGHTS, err);
        return false;
    }
    return true;
}

/**
 Crea tablella della GLICEMIA
 */
- (BOOL)createTableGlicosic {
    char *err;
    NSString *query = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                       "INTEGER PRIMARY KEY, '%@' REAL, '%@' REAL, '%@' REAL, '%@' REAL);",
                       TABLE_NAME_GLIOCOSIC,
                       @"id",
                       KEY_DATA, //1...
                       KEY_GLI_BASALE,
                       KEY_GLI_POSTPRANDIALE,
                       KEY_GLI_PREPRANDIALE];
    [self openDB];
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"*****ERRORE:Table %@ falied create. - %s", TABLE_NAME_WEIGHTS, err);
        return false;
    }
    return true;
}
@end
