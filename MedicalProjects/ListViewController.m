//
//  ListViewController.m
//  MedicalProjects
//
//  Created by Marco Velluto on 19/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "ListViewController.h"
#import "Database.h"
#import "Util.h"

@interface ListViewController ()
- (void)setViewForGlicemiaVersion:(Database *)db;
@end


@implementation ListViewController

typedef enum {
    TUTTI_BAR,
    BASALE_BAR,
    PREPRANDIALE_BAR,
    POSTPRANDIALE_BAR,
}typeSelectBar;

static NSString *key_value;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    Database *db = [[Database alloc] init];
    values = [[NSArray alloc] init];
    
    //-- Weight Version
    if ([Util version] == PESO) {
        key_value = KEY_WEIGHT;
        values = [db objectsFromWeight];

    }
    if ([Util version] == GLICEMIA) {
        //values = [db objectsFromGliocosic];
        [self setViewForGlicemiaVersion:db];
        key_value = KEY_VALUE;
    }
    if ([Util version] == PRESSIONE) {
        values = [db objectsFromPressures];
        key_value = KEY_VALUE;
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return values.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    // Configure the cell...
    int selectedTypeToView = self.selectedBar.selectedSegmentIndex;
    switch (selectedTypeToView) {
        case TUTTI_BAR:
            //
            break;
        case BASALAE:
            //
            break;
        case PREPRANDIALE:
            //
            break;
        case POSTPRANDIALE:
            //
            break;
        default:
            break;
    }
    NSDictionary *tempDic = [[NSDictionary alloc] init];
    tempDic = [values objectAtIndex:indexPath.row];

    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 186, 21)];
    labelName.text = [tempDic objectForKey:key_value];
    cell.textLabel.text = labelName.text;
    //[cell addSubview:labelName];

    UILabel *labelData = [[UILabel alloc] initWithFrame:CGRectMake(163, 68, 137, 21)];
    double timeInterval = [[tempDic objectForKey:KEY_DATA] doubleValue];
    labelData.text = [Util data:&timeInterval];
    cell.detailTextLabel.text = labelData.text;

    int version = [Util version];
    switch (version) {
        case PESO:
            //
            break;
            
        case GLICEMIA:
            [self setImageForGlicemia:tempDic cell:cell];
            break;
        case PRESSIONE:
            //
            break;
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)setImageForGlicemia:(NSDictionary *)tempDic cell:(UITableViewCell *)cell
{
    UIImage *image;
    int value = [[tempDic valueForKey:KEY_TYPE] intValue];
    switch (value) {
        case BASALAE:
            image = [UIImage imageNamed:@"OvalNero.png"];
            break;
            
        case PREPRANDIALE:
            image = [UIImage imageNamed:@"OvalBlue.png"];
            break;
            
        case POSTPRANDIALE:
            image = [UIImage imageNamed:@"OvalRed.png"];
            break;
            
        default:
            image = [UIImage imageNamed:@"OvalError.png"];
            break;
    }
    
    cell.image = image;
}

- (void)setViewForGlicemiaVersion:(Database *)db {
    int selectedTypeToView = self.selectedBar.selectedSegmentIndex;
    switch (selectedTypeToView) {
        case TUTTI_BAR:
            values = [db objectsFromGliocosic];
            break;
        case BASALAE:
            values = [db objectsBasaleFromGliocosic];
            break;
        case POSTPRANDIALE:
            values = [db objectsPostprandialeFromGliocosic];
            break;
        case PREPRANDIALE:
            values = [db objectsPreprandialeFromGliocosic];
            break;
        default:
            break;
    }
}

- (IBAction)pressSelectedBar:(id)sender {
    [self viewWillAppear:YES];
}
@end
