//
//  ListViewController.h
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController {
    NSArray *values;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedBar;

- (IBAction)pressSelectedBar:(id)sender;
@end
