//
//  THLanguageSwitch.m
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

#import "THLanguageSwitch.h"


static NSString *kCurrentTHLanguageSwitchKey = @"kCurrentTHLanguageSwitchKey";

@interface THLanguageSwitch()

@end

@implementation THLanguageSwitch


- (instancetype)init {
    if (self = [super init]) {
        NSString *currentLanguage = [[NSLocale preferredLanguages] firstObject];
        if ([currentLanguage isEqualToString:@"zh-Hans-CN"] ||
            [currentLanguage isEqualToString:@"zh-Hans-US"]) {
            currentLanguage = @"zh-Hans";
        } else if ([currentLanguage isEqualToString:@"zh-Hant-HK"] ||
                   [currentLanguage isEqualToString:@"zh-Hant-TW"] ||
                   [currentLanguage isEqualToString:@"zh-Hant-MO"]) {
            currentLanguage = @"zh-Hant";
        } else {
            currentLanguage = [[currentLanguage componentsSeparatedByString:@"-"] firstObject];
        }
        NSString *savedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentTHLanguageSwitchKey];
        if (savedLanguage.length <= 0) {
            _language = [self getLanguageCodeByLocale:currentLanguage];
        } else {
            _language = savedLanguage;
        }
        NSLog(@"首次读取的语言是：%@", _language);
    }
    return self;
}

- (NSString *)getLanguageCodeByLocale:(NSString *)locale {
    if ([locale isEqualToString:@"zh-CN"] || [locale isEqualToString:@"cn"]) {
        return @"zh-Hans";
    }
    if ([locale isEqualToString:@"zh-MO"] ||
        [locale isEqualToString:@"zh-HK"] ||
        [locale isEqualToString:@"zh-TW"]) {
        return @"zh-Hant";
    }
    if ([locale isEqualToString:@"zh-Hans"] || [locale isEqualToString:@"zh-Hant"]) {
        return locale;
    }
    NSArray *arr = [locale componentsSeparatedByString:@"-"];
    if (arr.count > 1) {
        return arr[0];
    }
    return locale;
}

+ (instancetype)shared {
    static THLanguageSwitch *languageToggleInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageToggleInstance = [[[self class] alloc] init];
    });
    return languageToggleInstance;
}

- (void)setLanguage:(NSString *)language {
    NSString *locale = [self getLanguageCodeByLocale:language];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:locale forKey:kCurrentTHLanguageSwitchKey];
    [userDefault synchronize];
    _language = locale;
}

- (NSBundle *)getLanguageBundleWithLanguage:(NSString *)languageStr {
    NSString *languagepath = [[NSBundle mainBundle] pathForResource:languageStr ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:languagepath];
    return bundle;
}

- (NSString *)localizedString:(NSString *)key {
    NSString *keystr = [[self getLanguageBundleWithLanguage:self.language] localizedStringForKey:key value:nil table:nil];
    if (keystr.length <= 0) {
        return key;
    }
    return keystr;
}


/***** 非该单例对象里的，而是直接实例化获取的 ******/
+ (NSString *)localizedString:(NSString *)key language:(NSString *)languageStr {
    NSString *lang = languageStr;
    if ([languageStr isEqualToString:@"us"]) {
        lang = @"en";
    } else if ([languageStr isEqualToString:@"cn"]) {
        lang = @"zh-Hans";
    } else if ([languageStr isEqualToString:@"tw"]) {
        lang = @"zh-Hant";
    } else if ([languageStr isEqualToString:@"jp"]) {
        lang = @"ja";
    } else if ([languageStr isEqualToString:@"kr"]) {
        lang = @"ko";
    }  else if ([languageStr isEqualToString:@"in"]) {
        lang = @"hi";
    }
    THLanguageSwitch *languageToggleInstance = [[[self class] alloc] init];
    NSBundle *languageBundle = [languageToggleInstance getLanguageBundleWithLanguage:lang];
    return [languageBundle localizedStringForKey:key value:nil table:nil];
}


@end
