//
//  ShowViewController.m
//  SqlNoteBook
//
//  Created by lin on 15/7/19.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ShowViewController.h"

@implementation NoteBookRecord

@end


@interface ShowViewController ()

@property NSString *dbPath;

@end

@implementation ShowViewController {
    sqlite3 *noteDB;
    NSMutableArray *noteArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    noteArray = [NSMutableArray array];
    self.dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.dbPath = [NSString stringWithFormat:@"%@/NoteDB.sqlite",self.dbPath];
    NSLog(@"%@",self.dbPath);
    const char *path = [self.dbPath UTF8String];
    if (sqlite3_open(path, &noteDB) == SQLITE_OK) {
        const char *sql_query = "select time from notebook";
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(noteDB, sql_query, -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NoteBookRecord *record = [[NoteBookRecord alloc] init];
                record.time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSLog(@"%@",record.time);
                [noteArray addObject:record];
            }
        }
        sqlite3_free(statement);
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [noteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NoteBookRecord *note = (NoteBookRecord *)noteArray[indexPath.row];
    cell.textLabel.text = note.time;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteBookRecord *rec = (NoteBookRecord *)noteArray[indexPath.row];
    NSString *time = rec.time;
    [noteArray removeObjectAtIndex:indexPath.row];
    
/*  此种方法为直接执行法，直接用sqlite3_exec执行
    
    const char *sql_str = [[NSString stringWithFormat:@"delete from notebook where time = %@",time] UTF8String];
    if (sqlite3_exec(noteDB, sql_str, nil, nil, nil) == SQLITE_OK) {
        NSLog(@"删除成功");
    }
    
*/
    

//此种方法结合准备语句（sqlite3_prepare_v2）、参数值绑定语句(sqlite_bind_text) 、 执行语句（sqlite3_step）,适合批量语句执行
    sqlite3_stmt *statement;
    NSString *sql_query = @"delete from notebook where time = ?";
    const char *sql_str = [sql_query UTF8String];
    if (sqlite3_prepare_v2(noteDB, sql_str, -1, &statement,nil) == SQLITE_OK) {
        const char *timeStr = [time UTF8String];
        sqlite3_bind_text(statement, 1, timeStr, (int)strlen(timeStr), SQLITE_STATIC);
        sqlite3_step(statement);
    }
    [self.tableView reloadData];
}

#pragma property

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    }
    return _tableView;
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
