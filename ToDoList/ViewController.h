//
//  ViewController.h
//  ToDoList
//
//  Created by dmi on 22/09/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UITextField *addItem;
@property (nonatomic) NSString *tasks;
- (IBAction)addItemButton:(UIBarButtonItem *)sender;




@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain)NSFetchedResultsController *fetchedResultsController;

@end
