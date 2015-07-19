//
//  EditViewController.h
//  SqlNoteBook
//
//  Created by lin on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface EditViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *textFields;
@property (strong, nonatomic) UIButton *addButton;

@end
