//
//  ViewController.h
//  SqlNoteBook
//
//  Created by lin on 15/7/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
#import "ShowViewController.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate , UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *showButton;

@end

