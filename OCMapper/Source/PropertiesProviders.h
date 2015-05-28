//
//  PropertiesProviders.h
//  ObjectMapping
//
//  Created by Anton Belousov on 28/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PropertiesMappingProvider
+ (NSArray * __nonnull)propertyProvidersList;
@end


@interface PropertyProvider: NSObject
@property (nonatomic, readonly, copy) NSString * __nonnull dictionaryKey;
@property (nonatomic, readonly, copy) NSString * __nonnull propertyName;
@property (nonatomic, readonly, copy) id __nullable transformer;
@property (nonatomic, readonly) Class __nullable objectType;
- (nonnull instancetype)initWithDictionaryKey:(NSString * __nonnull)dictionaryKey propertyName:(NSString * __nullable)propertyName objectType:(Class __nullable)objectType transformer:(id __nullable)transformer;
@end


@protocol DatePropertiesMappingProvider
+ (NSArray * __nonnull)datePropertyProvidersList;
@end


@interface DateFormatterProvider: NSObject
@property (nonatomic, readonly, copy) NSString * __nonnull propertyName;
@property (nonatomic, readonly) NSDateFormatter * __nonnull dateFormatter;
- (nonnull instancetype)initWithPropertyName:(NSString * __nonnull)propertyName dateFormatter:(NSDateFormatter * __nonnull)dateFormatter;
@end