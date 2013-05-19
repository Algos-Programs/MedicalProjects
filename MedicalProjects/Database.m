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

@interface Database ()
- (void)closeDb;

@end

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

- (void) closeDb {
    sqlite3_close(db);
}

//************************************
#pragma mark - Creazione Tabelle
//************************************

/// Crea tablella dei PESI
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

/// Crea tablella della PRESSIONE
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

/// Crea tablella della GLICEMIA
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
                     "VALUES ('%d','%f','%f')", TABLE_NAME_WEIGHTS, @"id",KEY_DATA, KEY_WEIGHT, countOfDb, date, weight];
    
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Not Posssible Insert New Record In %@, with error: '%s'", TABLE_NAME_WEIGHTS,err);
        return FALSE;
    }
    return TRUE;
}

- (BOOL)insertGlicoicWithBasale:(double)basale withPrepardiale:(double)prepard withPostPrandiale:(double)post withDate:(double)date {
    int countOfDb = 0;
    [self openDB];
    countOfDb = [self countOfDbFromGliocosic] + 1;
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@','%@','%@','%@','%@')"
                     "VALUES ('%d','%f','%f','%f','%f')", TABLE_NAME_GLIOCOSIC, @"id",KEY_DATA, KEY_GLI_BASALE, KEY_GLI_PREPRANDIALE, KEY_GLI_POSTPRANDIALE, countOfDb, date, basale, prepard, post];
    
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Not Posssible Insert New Record In %@, with error: '%s'", TABLE_NAME_WEIGHTS,err);
        return FALSE;
    }
    return TRUE;

}

- (BOOL)insertPressreWithPressMax:(double)pressMax withPresMin:(double)pressMin withDate:(double)date {
    int countOfDb = 0;
    [self openDB];
    countOfDb = [self countOfDbFromPressures] + 1;
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@','%@','%@','%@')"
                     "VALUES ('%d','%f','%f','%f')", TABLE_NAME_PRESSURES, @"id",KEY_DATA, KEY_PRE_MAX, KEY_PRE_MIN, countOfDb, date, pressMax, pressMin];
    
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Not Posssible Insert New Record In %@, with error: '%s'", TABLE_NAME_PRESSURES,err);
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

- (int)countOfDbFromGliocosic {
    [self createTableGlicosic];
    return [self countOfDbFromTableNamed:TABLE_NAME_GLIOCOSIC];
}

- (int)countOfDbFromPressures {
    [self createTablePressure];
    return [self countOfDbFromTableNamed:TABLE_NAME_PRESSURES];
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
#pragma mark - Delete Table Methods
//************************************

- (BOOL)deleteTableWeights {
    return [self deleteTableNamed:TABLE_NAME_WEIGHTS];
}

- (BOOL)deleteTableGliocosic {
    return [self deleteTableNamed:TABLE_NAME_GLIOCOSIC];
}

- (BOOL)deleteTablePressure {
    return [self deleteTableNamed:TABLE_NAME_PRESSURES];
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

//************************************
#pragma mark - Delete record Method
//************************************

- (BOOL)deleteRowFromWeightWithIndex:(int)index {
    return [self deleteRowFromTableNamed:TABLE_NAME_WEIGHTS withId:index];
}

- (BOOL)deleteRowFromGliocosicWithIndex:(int)index{
    return [self deleteRowFromTableNamed:TABLE_NAME_GLIOCOSIC withId:index];
}

- (BOOL)deleteRowFromPressuresWithIndex:(int)index {
    return [self deleteRowFromTableNamed:TABLE_NAME_PRESSURES withId:index];
}

- (BOOL)deleteRowFromTableNamed:(NSString *)tableName withId:(int)index {
    NSString *str = [tableName stringByAppendingFormat:@".id"];
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %i", tableName, str, index];
    sqlite3_stmt *compiledStatement;
    char *err;
    if (sqlite3_exec(db, [query UTF8String], nil, &compiledStatement, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Error Delete Record. '%s'", err);
        return FALSE;
    }
    return TRUE;
}

//************************************
#pragma mark - Get  Method
//************************************

- (NSArray *)objectsFromWeight {
    [self openDB];
    NSString * qsql = [NSString stringWithFormat:@"SELECT id,%@,%@ FROM '%@'", KEY_DATA, KEY_WEIGHT, TABLE_NAME_WEIGHTS];
    sqlite3_stmt *statment;
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statment, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statment) == SQLITE_ROW) {

            NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
            NSString *tempString = [[NSString alloc] init];
            
            //-- ID
            int field1 = (int) sqlite3_column_int(statment, 0);
            tempString = [NSString stringWithFormat:@"%i", field1];
            [mDic setValue:tempString forKey:@"id"];
            
            //-- DATA
            double field2 = (double) sqlite3_column_double(statment, 1);
            tempString = [NSString stringWithFormat :@"%f", field2];
            [mDic setValue:tempString forKey:KEY_DATA];
            
            //-- WEIGHT
            double field3 = (double) sqlite3_column_double(statment, 2);
            tempString = [NSString stringWithFormat :@"%f", field3];
            [mDic setValue:tempString forKey:KEY_WEIGHT];

            [returnArray addObject:mDic];
        }//end while
        sqlite3_finalize(statment);
    }//end if
    else
        NSLog(@"***** Error do not possible get all pesi");

    return returnArray;
}

- (NSArray *)objectsFromPressures {
    [self openDB];
    NSString * qsql = [NSString stringWithFormat:@"SELECT id,%@,%@,%@ FROM '%@'", KEY_DATA, KEY_PRE_MAX, KEY_PRE_MIN, TABLE_NAME_PRESSURES];
    sqlite3_stmt *statment;
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statment, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statment) == SQLITE_ROW) {
            
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
            NSString *tempString = [[NSString alloc] init];
            
            //-- ID
            int field1 = (int) sqlite3_column_int(statment, 0);
            tempString = [NSString stringWithFormat:@"%i", field1];
            [mDic setValue:tempString forKey:@"id"];
            
            //-- DATA
            double field2 = (double) sqlite3_column_double(statment, 1);
            tempString = [NSString stringWithFormat :@"%f", field2];
            [mDic setValue:tempString forKey:KEY_DATA];
            
            //-- PRESSIONE MAX
            double field3 = (double) sqlite3_column_double(statment, 2);
            tempString = [NSString stringWithFormat :@"%f", field3];
            [mDic setValue:tempString forKey:KEY_PRE_MAX];
            
            //-- PRESSIONE MIN
            double field4 = (double) sqlite3_column_double(statment, 3);
            tempString = [NSString stringWithFormat :@"%f", field4];
            [mDic setValue:tempString forKey:KEY_PRE_MIN];
            
            
            [returnArray addObject:mDic];
        }//end while
        sqlite3_finalize(statment);
    }//end if
    else
        NSLog(@"***** Error do not possible get all pesi");
    
    return returnArray;

}

- (NSArray *)objectsFromGliocosic {
    [self openDB];
    NSString * qsql = [NSString stringWithFormat:@"SELECT id,%@,%@,%@,%@ FROM '%@'", KEY_DATA, KEY_GLI_BASALE, KEY_GLI_POSTPRANDIALE, KEY_GLI_PREPRANDIALE, TABLE_NAME_GLIOCOSIC];
    sqlite3_stmt *statment;
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statment, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statment) == SQLITE_ROW) {
            
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
            NSString *tempString = [[NSString alloc] init];
            
            //-- ID
            int field1 = (int) sqlite3_column_int(statment, 0);
            tempString = [NSString stringWithFormat:@"%i", field1];
            [mDic setValue:tempString forKey:@"id"];
            
            //-- DATA
            double field2 = (double) sqlite3_column_double(statment, 1);
            tempString = [NSString stringWithFormat :@"%f", field2];
            [mDic setValue:tempString forKey:KEY_DATA];
            
            //-- GLICEMIA BASALE
            double field3 = (double) sqlite3_column_double(statment, 2);
            tempString = [NSString stringWithFormat :@"%f", field3];
            [mDic setValue:tempString forKey:KEY_GLI_BASALE];
            
            //-- GLICEMIA POSTPRANDIALE
            double field4 = (double) sqlite3_column_double(statment, 3);
            tempString = [NSString stringWithFormat :@"%f", field4];
            [mDic setValue:tempString forKey:KEY_GLI_POSTPRANDIALE];
            
            //-- GLICEMIA PREPARDIALE
            double field5 = (double) sqlite3_column_double(statment, 4);
            tempString = [NSString stringWithFormat :@"%f", field5];
            [mDic setValue:tempString forKey:KEY_GLI_PREPRANDIALE];

            [returnArray addObject:mDic];
        }//end while
        sqlite3_finalize(statment);
    }//end if
    else
        NSLog(@"***** Error do not possible get all pesi");
    
    return returnArray;

}

@end





















