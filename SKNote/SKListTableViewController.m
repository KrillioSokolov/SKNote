//
//  SKListTableViewController.m
//  SKNote
//
//  Created by Kirill on 03.11.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import "SKListTableViewController.h"
#import "SKCreateViewController.h"
@interface SKListTableViewController ()

@property (nonatomic, strong) NSArray *notes;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) UIColor *myGoldColor;
@end

@implementation SKListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notes = [NSArray new];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.myGoldColor = [UIColor colorWithRed:217.f / 255.f green:203.f / 255.f blue:158.f / 255.f alpha:1.0];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.notes = [[NSUserDefaults standardUserDefaults] arrayForKey:@"arr"];
    
    [self.tableView reloadData];
}

- (IBAction)editButton:(UIBarButtonItem*)sender {
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing) {
        self.tableView.editing = NO;
        
        [self.userDefaults setObject:self.notes forKey:@"arr"]; //for deleting
        
        sender.style = UIBarButtonSystemItemEdit;
        
    } else{
        
        self.tableView.editing = YES;
        
        item = UIBarButtonSystemItemDone;
        
        
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action: @selector(editButton:)];
    
    [self.navigationItem setLeftBarButtonItem:editButton animated:YES];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if ([self.notes count] > 0) {
        
        NSString* stringKey = [self.notes objectAtIndex:indexPath.row];
        
        cell.textLabel.text = stringKey;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *arrForDelete = [[NSMutableArray alloc] initWithArray:self.notes];
        
        [arrForDelete removeObjectAtIndex:indexPath.row];
        
        self.notes = [[NSArray alloc]initWithArray:arrForDelete];
        
        [self.userDefaults setObject:self.notes forKey:@"arr"];

        [tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SKCreateViewController *vc = (SKCreateViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SKCreateViewController"];
    
    NSString* stringKey = [self.notes objectAtIndex:indexPath.row];
    NSString* stringHeader = [self.userDefaults stringForKey:stringKey];
    
    vc.head = stringKey;
    vc.cont = stringHeader;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
    
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(0 - CGRectGetWidth(cell.frame), CGRectGetMinY(cell.frame),
                                CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.frame = CGRectMake(0, CGRectGetMinY(cell.frame),
                                                    CGRectGetWidth(cell.frame),
                                                    CGRectGetHeight(cell.frame));
                         
                         cell.backgroundColor = self.myGoldColor;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor whiteColor];
                                          }];
                     }];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"Remove";
}


@end
