//
//  ViewController.m
//  VscLocalizedHelperDemo
//
//  Created by Visac MBP on 2017/8/16.
//  Copyright © 2017年 VincentChow. All rights reserved.
//

#import "ViewController.h"
#import "VscLocalizedHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VscLocalizedHelper *helper = [VscLocalizedHelper sharedHelper];
    [helper setBundleName:@"CTV.bundle" tableName:@"CurLanguage"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 50)];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:25];
    label.text = localizedStr(@"全选");
    [self.view addSubview:label];
    
    for (int index = 0; index < helper.allAppLanguages.count; index ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 110 + index * 50, 200, 45)];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:64];
        [btn setTitle:helper.allAppLanguages[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [self.view addSubview:btn];
    }
}
-(void)buttonClicked:(UIButton *)button{
    NSString *newLang = button.titleLabel.text;
    VscLocalizedHelper *helper = [VscLocalizedHelper sharedHelper];
    if (![helper.curLanguage isEqualToString:newLang]) {
        helper.rememberLang = YES;
        helper.curLanguage = newLang;
        abort();
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
