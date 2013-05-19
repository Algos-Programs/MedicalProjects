//
//  FirstViewController.m
//  MedicalProjects
//
//  Created by Marco Velluto on 16/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "FirstViewController.h"
#import "WeightView.h"
#import "DataType.h"
#import "Database.h"

@interface FirstViewController ()

- (int)setVersion;
- (void)prepareViewWeight;
- (void)keyboardDown;

- (IBAction)pressButtonSave:(id)sender;
@end

@implementation FirstViewController

static BOOL WEIGHTs_VERSION = NO;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setVersion];
    [self prepareViewWeight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 Imposta la variabile bool a seconda del progetto che si sta eseguendo.
 @return 1 - Weight Version
 @return 2 - Glioco Version
 @return 3 - Pressu Version
 
 @return -1 se non riconosce la versione.
 */
- (int)setVersion {
    WEIGHTs_VERSION = YES;
    return 1;
}

///Fa scomparire la tastira.
- (void)keyboardDown {
    [self.textField resignFirstResponder];
}

/// Inserisce i componenti nella view.
- (void)prepareViewWeight {
    UIButton *bottom = [WeightView button];
    [bottom addTarget:self action:@selector(pressButtonSave:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottom];
    
    
    //[self.view addSubview:[WeightView myTextField]];
    [self.view addSubview:[WeightView titleLabel]];
    [self.view addSubview:[WeightView dataLabel]];
}

//****************************
#pragma mark - Action Methods
//****************************

/// Quando l'utente fa click su save. Salva il valore.
- (IBAction)pressButtonSave:(id)sender {
    NSString *str = self.textField.text;
    if ([DataType checkValue:str]) {
        Database *db = [[Database alloc] init];
        if(![db insertWeight:[str doubleValue] withData:[[NSDate date] timeIntervalSince1970]]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/// Quando l'utente preme sulla schermata, fa scomparire la tastiera.
- (IBAction)pressOnScreen:(id)sender {
    [self keyboardDown];
}

/// Quando l'utente fa uno swipe sulla schermata, fa scomparire la tastiera.
- (IBAction)swipeOnScreen:(id)sender {
    [self keyboardDown];

}
@end
