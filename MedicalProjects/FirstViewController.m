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
#import "Costanti.h"
#import "Util.h"


@interface FirstViewController ()

- (int)setVersion;
- (void)prepareViewWeight;
- (void)prepareViewGlucose;
- (void)prepareViewPressure;
- (void)keyboardDown;

- (IBAction)pressButtonSave:(id)sender;
@end

@implementation FirstViewController

static int version = -1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pickerView setDelegate:self];
    [self setVersion];
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
    version = [Util version];
    switch (version) {
        case TAGET_WEIGHT:
            [self prepareViewWeight];
            break;
        case TAGET_GLICEM:
            [self prepareViewGlucose];
            break;
            
        case TAGET_PRESSU:
            [self prepareViewPressure];
            break;
            
        default:
            //ERRORE.
            break;
    }
    
    return version;
}

///Fa scomparire la tastira.
- (void)keyboardDown {
    [self.textField resignFirstResponder];
}

/// Inserisce i componenti nella view.
- (void)prepareViewWeight {
    
    [self.buttonBasale setHidden:YES];
    [self.buttonPreprandiale setHidden:YES];
    [self.buttonPostprandiale setHidden:YES];
    [self.pickerView setHidden:YES];
    
    UIButton *bottom = [WeightView button];
    [bottom addTarget:self action:@selector(pressButtonSave:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottom];
    
    
    //[self.view addSubview:[WeightView myTextField]];
    [self.view addSubview:[WeightView titleLabel]];
    [self.view addSubview:[WeightView dataLabel]];
}

///Inserisce i componenti per la vista glucose.
- (void)prepareViewGlucose {
    [self.buttonBasale setHidden:NO];
    [self.buttonPostprandiale setHidden:NO];
    [self.buttonPreprandiale setHidden:NO];
    [self.pickerView setHidden:YES];
    
    //TODO: Inserire il titolo della navigation bar.
}

- (void)prepareViewPressure {
    [self.buttonBasale setHidden:YES];
    [self.buttonPostprandiale setHidden:YES];
    [self.buttonPreprandiale setHidden:YES];
}

//****************************
#pragma mark - Action Methods
//****************************

/// Quando l'utente fa click su save. Salva il valore.
- (IBAction)pressButtonSave:(id)sender {
    if (version == TAGET_WEIGHT) { //Weight
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
    
    if (version == TAGET_GLICEM) {
        NSString *str = self.textField.text;
        if ([DataType checkValue:str]) {
            Database *db = [[Database alloc] init];
            if(![db insertGlicosicBasale:[str doubleValue] withDate:[[NSDate date] timeIntervalSince1970]]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    if (version == TAGET_PRESSU) {
        NSString *str = self.textField.text;
        if ([DataType checkValue:str]) {
            Database *db = [[Database alloc] init];
            if(![db insertPressureMax:[str doubleValue] withDate:[[NSDate date] timeIntervalSince1970]]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
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

///Inserisce il valore della glicemia BASALE nel db.
- (IBAction)pressButtonBasale:(id)sender {
    NSString *str = self.textField.text;
    
    if ([DataType checkValue:str]) { // Controllo correttezza del valore.
        Database *db = [[Database alloc] init];
        if(![db insertGlicosicBasale:[str doubleValue] withDate:[[NSDate date] timeIntervalSince1970]]){ // Controllo inserimento corretto del valore.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

///Inserisce il valore della glicemia PREPRANDIALE presa dal textfield nel db.
- (IBAction)pressButtonPreprandiale:(id)sender {
    NSString *str = self.textField.text;
    
    if ([DataType checkValue:str]) { // Controllo correttezza del valore.
        Database *db = [[Database alloc] init];
        if(![db insertGlicosicPreprandiale:[str doubleValue] withDate:[[NSDate date] timeIntervalSince1970]]){ // Controllo inserimento corretto del valore.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

///Inserisce il valore della glicemia POSTRANDIALE presa dal textfield nel db.
- (IBAction)pressButtonPostprandiale:(id)sender {
    NSString *str = self.textField.text;
    
    if ([DataType checkValue:str]) { // Controllo correttezza del valore.
        Database *db = [[Database alloc] init];
        if(![db insertGlicosicPostprandiale:[str doubleValue] withDate:[[NSDate date] timeIntervalSince1970]]){ // Controllo inserimento corretto del valore.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è stato salvato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attenzione" message:@"Il valore inserito non è valido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//*********************************
#pragma mark - PickerView Delegate
//*********************************

///In quante sezioni è diviso il pickerView.
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

///Numero di righe in ogni sezione del picker.
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {    
    if (component == COMPONENT_BATTITO)
        return 81;
    else
        return 121;
}

//// Il valore di ogni riga di ogni sezione del picker.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (component) {
        case COMPONENT_BATTITO: //40 - 120
            title = [@"" stringByAppendingFormat:@"%d bpm",row + 40];
            break;
        
        case COMPONENT_DIASTOLICA: //60-180
            title = [@"" stringByAppendingFormat:@"%d mmHg",row + 60];
            break;
            
        case COMPONENT_SISTOLICA: //massima
            title = [@"" stringByAppendingFormat:@"%d mmHg",row + 60];
            break;

        default:
            break;
    }
    
    return title;
}

//// Larghezza di ogni componen (sezione) del picker.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100.0f;
}

/// Cosa avviene una volta che viene selezionata una riga.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

@end
