//
//  ViewController.m
//  TextFieldDemo
//
//  Created by 仝兴伟 on 17/4/10.
//  Copyright © 2017年 仝兴伟. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
@interface ViewController ()
@property (nonatomic, strong) UITextField *textFields;
@property (nonatomic, strong) UIButton *userButton;

@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addTextField];
}


- (void)addTextField {
    self.textFields = [[UITextField alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 300) / 2, 100, 300, 40)];
    self.textFields.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textFields];
    
    self.userButton = [[UIButton alloc]init];
    self.userButton.frame = CGRectMake(332, 110, 26, 14);

    [self.userButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [self.userButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [self.userButton addTarget:self action:@selector(userButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userButton];
    
    self.submitButton = [[UIButton alloc]init];
    self.submitButton.frame = CGRectMake((self.view.bounds.size.width - 300) / 2, 300, 300, 40);
    self.submitButton.backgroundColor = [UIColor redColor];
    [self.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
}

- (void)userButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    NSLog(@"%d", button.selected);
    
    // 根据点击弹出pop控件
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:button withActions:[self QQActions]];
}

- (NSArray<PopoverAction *> *)QQActions {
    
    // 加载plist文件中的账号设置，遍历plist文件，创建不同的pop
    // 读取文件内容
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    NSLog(@"读取文件内容=== %@", data1);
    
    
    
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        NSLog(@"%@", action.title);
//        _noticeLabel.text = action.title;
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        NSLog(@"%@", action.title);

//        _noticeLabel.text = action.title;
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        NSLog(@"%@", action.title);

//        _noticeLabel.text = action.title;
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
        NSLog(@"%@", action.title);

//        _noticeLabel.text = action.title;
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        NSLog(@"%@", action.title);

//        _noticeLabel.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction, multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction, multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction, multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}

#pragma mark -- 提交按钮  并将信息写入到  plist文件中


- (void)submitButtonClick : (UIButton *)button  {
    // 获取文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@ "userInfo.plist" ];
    NSLog(@"文件路径----%@", fileName);
    // 写入
   NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
    [newsDict setObject:self.textFields.text forKey:self.textFields.text];
    [newsDict writeToFile:fileName atomically:YES];//执行此行代码时默认新创建一个plist文件
}



- (void)submitButtonClicks : (UIButton *)button {
    // 读取plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    
    //添加一项内容
    [data setObject:self.textFields.text forKey:self.textFields.text];
    NSLog(@"%@", data);
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserInfo.plist"];
    //输入写入
    [data writeToFile:filename atomically:YES];
    NSLog(@"%@", filename);
    
    //那怎么证明我的数据写入了呢？读出来看看
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"%@", data1);

}






















@end
