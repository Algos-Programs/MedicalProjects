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
@end
