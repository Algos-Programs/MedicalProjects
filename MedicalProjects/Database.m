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
    [self openDB];
    char *err;
    NSString *query = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                        "INTEGER PRIMARY KEY, '%@' REAL, '%@' REAL);",
                        TABLE_NAME_WEIGHTS,
                        @"id",
                        KEY_DATA, //1...
                        KEY_WEIGHT];
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

//************************************
#pragma mark - Inserimento Record
//************************************

- (BOOL)insertWeight:(double)weight withData:(double)date {
    int countOfDb = 0;
    [self openDB];
    countOfDb = [self countOfDbFromWeights] + 1;
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@','%@','%@')"
                     "VALUES ('%d','%f','%f')", TABLE_NAME_WEIGHTS, @"id",KEY_DATA, KEY_WEIGHT, countOfDb, weight, date];
    
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Not Posssible Insert New Record In %@, with error: '%s'", TABLE_NAME_WEIGHTS,err);
        return FALSE;
    }
    return TRUE;
}

//************************************
#pragma mark - Count 
//************************************

- (int)countOfDbFromWeights {
    [self createTableWeight];
    return [self countOfDbFromTableNamed:TABLE_NAME_WEIGHTS];
}

- (int)countOfDbFromTableNamed:(NSString *)tableName {
    NSString * qsql = [NSString stringWithFormat:@"SELECT * FROM '%@'", tableName];
    sqlite3_stmt *statment;
    
    int count = 0;
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statment, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statment) == SQLITE_ROW) {
            count ++;
        }
        //-- Delete the compiler statment from memory
        sqlite3_finalize(statment);
    }
    else
        NSLog(@"****** Error Count of DB");
    return count;
}

//************************************
#pragma mark - Delete Table
//************************************

- (BOOL)deleteTableWeights {
    return [self deleteTableNamed:TABLE_NAME_WEIGHTS];
}

- (BOOL)deleteTableNamed:(NSString *)tableName {
    [self openDB];
    NSString *query = [NSString stringWithFormat:@"DROP TABLE \"main\".\"%@\"", tableName];
    char *err;
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Error Delete table %@, with error. '%s'", tableName ,err);
        return FALSE;
    }
    return TRUE;
}

@end
