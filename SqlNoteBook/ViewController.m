//
//  ViewController.m
//  SqlNoteBook
//
//  Created by lin on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.bgView.image = [UIImage imageNamed:@"森林少女.jpg"];
    [self.view addSubview:self.bgView];
    
    self.navigationItem.title = @"记事本";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置背景图片" style:UIBarButtonItemStylePlain target:self action:@selector(setButton)];
    self.navigationItem.rightBarButtonItem.title = @"设置背景图片";
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 120, 40)];
    [self.addButton setTitle:@"添加日志" forState:UIControlStateNormal];
    self.addButton.backgroundColor = [UIColor whiteColor];
    self.addButton.layer.cornerRadius = 8;
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    self.addButton.center = CGPointMake(self.view.center.x - 90, 500);
    [self.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    self.showButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 120, 40)];
    [self.showButton setTitle:@"查询日志" forState:UIControlStateNormal];
    self.showButton.backgroundColor = [UIColor whiteColor];
    self.showButton.layer.cornerRadius = 8;
    self.showButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    self.showButton.center = CGPointMake(self.view.center.x +90, 500);
    [self.showButton addTarget:self action:@selector(showButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonClicked {
    [self showViewController:[[EditViewController alloc] init] sender:self];
    //[self presentViewController:[[EditViewController alloc] init] animated:YES completion:nil];
}

- (void)showButtonClicked {
    [self.navigationController pushViewController:[[ShowViewController alloc] init] animated:YES];
}

- (void)setButton {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.bgView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

@end
