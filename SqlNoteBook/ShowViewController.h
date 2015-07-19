//
//  ShowViewController.h
//  SqlNoteBook
//
//  Created by lin on 15/7/19.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface NoteBookRecord : NSObject

@property NSString *time;
@property NSString *address;
@property NSString *thing;
@property NSString *people;
@property NSString *note;

@end

@interface ShowViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
