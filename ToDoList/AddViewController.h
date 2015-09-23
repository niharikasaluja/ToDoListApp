//
//  AddViewController.h
//  ToDoList
//
//  Created by dmi on 22/09/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *addItem;
@property (nonatomic) NSString *tasks;
- (IBAction)addItemButton:(id)sender;


@end
