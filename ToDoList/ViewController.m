//
//  ViewController.m
//  ToDoList
//
//  Created by dmi on 22/09/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import <CoreData/CoreData.h>
@interface ViewController ()


@property(nonatomic) NSMutableArray *results;


@end

@implementation ViewController

NSString *attributeName = @"name";
@synthesize fetchedResultsController = _fetchedResultsController;



-(NSManagedObjectContext *)managedObjectContext
{

    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    self.view.backgroundColor = [UIColor redColor];
    }

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ToDoTasks"];
    //  NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoTasks" inManagedObjectContext:self.managedObjectContext];
    //[fetchRequest setEntity:entity];
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tasks are : %@",attributeName];
//    [fetchRequest setPredicate:predicate];
    
    self.results = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        
        NSLog(@"Failure");
        NSLog(@"%@ , %@ " , error , error.localizedDescription);
    }
    
    else
    {
        
        NSLog(@"%@" , results);
        
    }
    
     [self.tableView reloadData ];
    //self.editing = YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
//    NSArray *sections = [self.fetchedResultsController sections];
//    
//    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
//    
//    CAGradientLayer *grad = [CAGradientLayer layer];
//    grad.frame = cell.bounds;
//    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:255/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:23.0/255.0 green:26.0/255.0 blue:29.0/255.0 alpha:1.0] CGColor], nil];
//    
//    [cell setBackgroundView:[[UIView alloc] init]];
//    [cell.backgroundView.layer insertSublayer:grad atIndex:0];

    self.view.backgroundColor = [UIColor orangeColor];
    
    // Configure the cell...
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
//        
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = cell.bounds;
//        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor redColor]CGColor], nil];
//        [cell.layer addSublayer:gradient];
    }
   
    NSManagedObject *managedObject = [self.results objectAtIndex:indexPath.row];
    
    cell.textLabel.text =[managedObject valueForKey:@"name"];
    
  //  cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.accessoryType == UITableViewCellAccessoryNone)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
    
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    }
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{

    NSArray *newIndexPathArray = nil;
    NSArray *oldIndexPathArray = nil;

    switch (type) {
        case NSFetchedResultsChangeInsert:
            newIndexPathArray = @[newIndexPath];
            
            [[self tableView] insertRowsAtIndexPaths:newIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            oldIndexPathArray = @[indexPath];
            
            [[self tableView] deleteRowsAtIndexPaths:newIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
            break;
            
//        case NSFetchedResultsChangeUpdate:
//            newIndexPathArray = @[newIndexPath];
//            
//            [[self tableView] insertRowsAtIndexPaths:newIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
//            break;
        default:
            break;
    }

}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{

    [self.tableView endUpdates];

}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.results objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete ! %@ %@" , error, [error localizedDescription]);
            return;
        }
        [self.results removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;

}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
