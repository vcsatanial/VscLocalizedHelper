//
//  VscLocalizedHelper.h
//  VscCoreTextViewDemo
//
//  Created by Visac MBP on 2017/8/14.
//  Copyright © 2017年 VincentChow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NSString *localizedStr(NSString *keyStr);
@interface VscLocalizedHelper : NSObject<UIAlertViewDelegate>
@property (nonatomic,copy) NSString *userLanguage;
@property (nonatomic,copy,readonly) NSString *bundleName;
@property (nonatomic,copy,readonly) NSString *tableName;
@property (nonatomic,copy,readonly) NSArray *allAppLanguages;
@property (nonatomic,copy) NSString *curLanguage;
@property (nonatomic,assign) BOOL rememberLang;
@property (nonatomic,strong) NSBundle *bundle;
+(VscLocalizedHelper *)sharedHelper;
-(void)setBundleName:(NSString *)bundleName tableName:(NSString *)tableName;
@end
