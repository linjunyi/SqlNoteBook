//
//  EditViewController.m
//  SqlNoteBook
//
//  Created by lin on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController {
    NSString *docDir;
    NSString *dataDBPath;
    sqlite3 *noteDB;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.textFields = [NSMutableArray array];
    [self setLabels];
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 100, 40)];
    [self.addButton setTitle:@"新增" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.addButton.layer.cornerRadius = 8;
    self.addButton.backgroundColor = [UIColor whiteColor];
    self.addButton.center = CGPointMake(self.view.center.x, 530);
    [self.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    //创建并连接数据库
    docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    dataDBPath = [NSString stringWithFormat:@"%@/NoteDB.sqlite", docDir];
    NSLog(@"%@",dataDBPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:dataDBPath]){
        const char *dbpath = [dataDBPath UTF8String];
        if(sqlite3_open(dbpath, &noteDB) == SQLITE_OK) {
            char *errorMsg;
            const char *sql_query = "create table if not exists notebook (time text, address text, thing text, people text, note text)";
            if(sqlite3_exec(noteDB, sql_query, nil, nil, &errorMsg) == SQLITE_OK) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"创建数据库成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else {
                printf("%s",errorMsg);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabels {
    NSArray *labelTexts = [NSArray arrayWithObjects:@"时间", @"地点", @"事情", @"参与人", @"备注", nil];
    for (NSInteger i=0; i<5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 100+50*i, 150, 40)];
        label.text = labelTexts[i];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 8;
        if(i == 4) {
            textField.frame = CGRectMake(0, 0, 200, 160);
            textField.center = CGPointMake(label.center.x+80, label.center.y + 80 - 16.5);
        } else {
            textField.center = CGPointMake(label.center.x+80, label.center.y);
        }
        [self.textFields addObject:textField];
        [self.view addSubview:label];
        [self.view addSubview:textField];
    }
}

- (void)addButtonClicked {
    const char *dbPath = [dataDBPath UTF8String];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<5; i++) {
        UITextField *field = (UITextField *)self.textFields[i];
        [array addObject:field.text];
    }
    if(sqlite3_open(dbPath, &noteDB) == SQLITE_OK) {
        NSString *sql_str = [NSString stringWithFormat:@"insert into notebook(time, address, thing, people, note) values(\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", array[0], array[1], array[2], array[3], array[4]];
        const char *sql_query = [sql_str UTF8String];
        char *errorMsg;
        if(sqlite3_exec(noteDB, sql_query, nil, nil, &errorMsg) == SQLITE_OK) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新增日志成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            NSLog(@"%@",[NSString stringWithUTF8String:errorMsg]);
        }
    }
    
    [self.textFields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
