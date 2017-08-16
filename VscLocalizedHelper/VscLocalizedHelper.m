
//
//  VscLocalizedHelper.m
//  VscCoreTextViewDemo
//
//  Created by Visac MBP on 2017/8/14.
//  Copyright © 2017年 VincentChow. All rights reserved.
//

#import "VscLocalizedHelper.h"

NSString *localizedStr(NSString *keyStr){
    VscLocalizedHelper *helper = [VscLocalizedHelper sharedHelper];
    NSString *showStr = [helper.bundle localizedStringForKey:keyStr value:nil table:helper.tableName];
    return showStr;
}

@interface VscLocalizedHelper (){
    NSString *_bundleName;
    NSArray *_allAppLanguages;
    NSUserDefaults *_defaults;
}
@property (nonatomic,copy,readonly) NSUserDefaults *defaults;
@property (nonatomic,copy,readonly) NSString *systemLanguage;
@property (nonatomic,copy,readonly) NSString *lastRemLanguage;
@property (nonatomic,copy) NSString *appLanguage;

@end

NSString *const currentLanguage = @"currentLanguage";
NSString *const systemLanguage  = @"systemLanguage";
NSString *const lastRemLanguage = @"lastRemLanguage";

@implementation VscLocalizedHelper
+(VscLocalizedHelper *)sharedHelper{
    static VscLocalizedHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[VscLocalizedHelper alloc] init];
    });
    return helper;
}
-(NSString *)bundleName{
    if ([_bundleName containsString:@".bundle"]) {
        _bundleName = [_bundleName stringByReplacingOccurrencesOfString:@".bundle" withString:@""];
    }
    return _bundleName;
}
-(NSUserDefaults *)defaults{
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}
-(NSString *)systemLanguage{
    return [self.defaults objectForKey:@"AppleLanguages"][0];
}
-(NSArray *)allAppLanguages{
    if (!_allAppLanguages) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:self.bundleName ofType:@"bundle"];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSMutableArray *addArray = [NSMutableArray array];
        NSArray *pathArray = [fm contentsOfDirectoryAtPath:bundlePath error:nil];
        for (NSString *str in pathArray) {
            if ([str containsString:@".lproj"]) {
                NSString *langStr = [str stringByReplacingOccurrencesOfString:@".lproj" withString:@""];
                [addArray addObject:langStr];
            }
        }
        _allAppLanguages = addArray.copy;
    }
    return _allAppLanguages;
}
-(void)setLastRemLanguage:(NSString *)_lastRemLanguage{
    [self.defaults setValue:_lastRemLanguage forKey:lastRemLanguage];
}
-(NSString *)lastRemLanguage{
    return [self.defaults valueForKey:lastRemLanguage];
}
-(NSString *)curLanguage{
    NSString *lang = [self.defaults valueForKey:currentLanguage];
    if (![self.allAppLanguages containsObject:lang]) {
        for (NSString *tempLang in self.allAppLanguages) {
            if ([lang containsString:tempLang]) {
                lang = tempLang;
                break;
            }
        }
    }
    return lang;
}
-(void)setCurLanguage:(NSString *)curLanguage{
    if (![self.allAppLanguages containsObject:curLanguage]) {
        for (NSString *langName in self.allAppLanguages) {
            if ([curLanguage containsString:langName]) {
                curLanguage = langName;
                break;
            }
        }
    }
    [self.defaults setValue:curLanguage forKey:currentLanguage];
    [self.defaults setValue:curLanguage forKey:systemLanguage];
    if (self.rememberLang) {
        self.lastRemLanguage = curLanguage;
    }
    [self.defaults synchronize];
}
-(void)setBundleName:(NSString *)bundleName tableName:(NSString *)tableName{
    _bundleName = bundleName;
    _tableName = tableName;
    NSString *language = self.curLanguage;
    
    if (language.length == 0 || !self.lastRemLanguage) {
        language = self.systemLanguage;
        self.curLanguage = language;
    }
    
    NSString *temBundlePath = [[NSBundle mainBundle] pathForResource:self.bundleName ofType:@".bundle"];
    NSBundle *tempBundle = [NSBundle bundleWithPath:temBundlePath];
    
    NSString *path = [tempBundle pathForResource:self.curLanguage ofType:@"lproj"];
    if (!path) {
        path = [tempBundle pathForResource:@"en" ofType:@"lproj"];
    }
    _bundle = [NSBundle bundleWithPath:path];
}
@end
