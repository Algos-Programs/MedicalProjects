//
//  FirstViewController.h
//  MedicalProjects
//
//  Created by Marco Velluto on 16/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)pressOnScreen:(id)sender;
- (IBAction)swipeOnScreen:(id)sender;

///GLICEMIA

@property (weak, nonatomic) IBOutlet UIButton *buttonBasale;
@property (weak, nonatomic) IBOutlet UIButton *buttonPreprandiale;
@property (weak, nonatomic) IBOutlet UIButton *buttonPostprandiale;

- (IBAction)pressButtonBasale:(id)sender;
- (IBAction)pressButtonPreprandiale:(id)sender;
- (IBAction)pressButtonPostprandiale:(id)sender;

@end
