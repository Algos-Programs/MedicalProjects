//
//  DatabaseGeneral.h
//  MedicalProjects
//
//  Created by Marco Velluto on 26/05/13.
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

@interface DatabaseGeneral : NSObject {
    sqlite3 *db;
}

@end
