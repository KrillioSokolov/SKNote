//
//  SKCreateViewController.h
//  SKNote
//
//  Created by Kirill on 03.11.16.
//  Copyright © 2016 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCreateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *headerTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (nonatomic, strong) NSString *cont;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *key;

@end
