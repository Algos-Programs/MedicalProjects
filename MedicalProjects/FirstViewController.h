//
//  FirstViewController.h
//  MedicalProjects
//
//  Created by Marco Velluto on 16/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate>

#pragma mark - Generali
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)pressOnScreen:(id)sender;
- (IBAction)swipeOnScreen:(id)sender;

#pragma mark - Glicemia

@property (weak, nonatomic) IBOutlet UIButton *buttonBasale;
@property (weak, nonatomic) IBOutlet UIButton *buttonPreprandiale;
@property (weak, nonatomic) IBOutlet UIButton *buttonPostprandiale;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)pressButtonBasale:(id)sender;
- (IBAction)pressButtonPreprandiale:(id)sender;
- (IBAction)pressButtonPostprandiale:(id)sender;

@end
