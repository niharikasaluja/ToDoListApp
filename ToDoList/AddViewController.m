//
//  AddViewController.m
//  ToDoList
//
//  Created by dmi on 22/09/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "AddViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
   
    // Do any additional setup after loading the view.
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.view.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor greenColor]CGColor], nil];
//    [self.view.layer addSublayer:gradient];
    
//    UIImage *background = [UIImage imageNamed: @"blue-sky-abstract-background-images-for-website"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
//    
//    [self.view addSubview: imageView];
//    
     [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)addItemButton:(id)sender {
    
    
    
    NSLog(@"Button tapped");
    if(self.addItem.text.length > 0)
    {
    
 AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   
   NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newTask ;
    
    newTask = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoTasks" inManagedObjectContext:context];
    
    [newTask setValue:self.addItem.text forKey:@"name"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Not success");
        
        [error localizedDescription];
    }
    
    NSLog(@" tasks : %@" , newTask);

        [appDelegate saveContext];
        
    }
    
    
    //ViewController *viewController ;
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
textField.text = @"";
    [textField resignFirstResponder];

}
@end
