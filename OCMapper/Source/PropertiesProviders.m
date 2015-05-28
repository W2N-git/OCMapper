//
//  PropertiesProviders.m
//  ObjectMapping
//
//  Created by Anton Belousov on 28/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "PropertiesProviders.h"

@interface PropertyProvider ()
@property (nonatomic, copy) NSString * __nonnull dictionaryKey;
@property (nonatomic, copy) NSString * __nonnull propertyName;
@property (nonatomic, copy) id __nullable transformer;
@property (nonatomic, strong) Class __nullable objectType;
@end

@implementation PropertyProvider

- (nonnull instancetype)initWithDictionaryKey:(NSString * __nonnull)dictionaryKey propertyName:(NSString * __nullable)propertyName objectType:(Class __nullable)objectType transformer:(id __nullable)transformer {
    if (self = [super init]) {
        self.dictionaryKey = dictionaryKey;

        if (propertyName == nil) {
            self.propertyName = dictionaryKey;
        } else {
            self.propertyName = propertyName;
        }
        
        self.objectType  = objectType;
        self.transformer = transformer;
    }
    return self;
}

@end


@interface DateFormatterProvider ()
@property (nonatomic, copy) NSString * __nonnull propertyName;
@property (nonatomic, strong) NSDateFormatter * __nonnull dateFormatter;
@end

@implementation DateFormatterProvider

- (nonnull instancetype)initWithPropertyName:(NSString * __nonnull)propertyName dateFormatter:(NSDateFormatter * __nonnull)dateFormatter {
    if (self = [super init]) {
        self.propertyName  = propertyName;
        self.dateFormatter = dateFormatter;
    }
    return self;
}

@end
