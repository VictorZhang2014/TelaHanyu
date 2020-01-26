//
//  THLanguageSwitch.h
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THLanguageSwitch : NSObject

@property (nonatomic, copy, readonly) NSString *language;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)shared;

- (void)setLanguage:(NSString *)language;

- (NSString *)localizedString:(NSString *)key;


/***** 非该单例对象里的，而是直接实例化获取的 ******/
+ (NSString *)localizedString:(NSString *)key language:(NSString *)languageStr;


@end

NS_ASSUME_NONNULL_END
