//
//  SKCreateViewController.m
//  SKNote
//
//  Created by Kirill on 03.11.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import "SKCreateViewController.h"
#import "SKListTableViewController.h"

@interface SKCreateViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation SKCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.headerTextField.text = self.head;
    self.contentTextView.text = self.cont;
}


- (IBAction)headerChanged:(id)sender {
    
    if ((self.headerTextField.text.length > 0)) {
        [self.saveButton setEnabled:YES];
    }
}


- (IBAction)SaveAcion:(UIBarButtonItem*)sender {
    
    NSMutableArray *arrWithHeader = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"arr"]];
    
    [arrWithHeader insertObject:self.headerTextField.text atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:arrWithHeader forKey:@"arr"];
    [[NSUserDefaults standardUserDefaults] setObject:self.contentTextView.text forKey:self.headerTextField.text];

    [self.navigationController popViewControllerAnimated:TRUE];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self.contentTextView becomeFirstResponder];
    
    return YES;
}

@end
