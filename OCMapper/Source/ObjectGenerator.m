//
//  ObjectGenerator+runtimeMappingProviderPopulate.m
//  ObjectMapping
//
//  Created by Anton Belousov on 27/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "ObjectGenerator.h"
#import "OCMapper-Swift.h"
#import <objc/runtime.h>

@interface ObjectMapper ()
@property (nonatomic, strong) NSMutableSet *runtimeAddedClasses;
@end


@implementation ObjectGenerator

- (NSMutableSet *)runtimeAddedClasses {
    id s = objc_getAssociatedObject(self, @selector(runtimeAddedClasses));
    
    if (s != nil) {
        return s;
    }

    s = [NSMutableSet new];
    self.runtimeAddedClasses = s;
    return s;
}

- (void)setRuntimeAddedClasses:(NSMutableSet *)runtimeAddedClasses{
    objc_setAssociatedObject(self, @selector(runtimeAddedClasses), runtimeAddedClasses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)processDictionary:(NSDictionary *)source forClass:(Class)class {
    [self populateMappingSelfProviderForClassIfNeeded:class];
    return [super processDictionary:source forClass:class];
}

- (void)populateMappingSelfProviderForClassIfNeeded:(Class)klass {
    
    NSLog(@"%s, LINE:%d, klass: %@", __PRETTY_FUNCTION__, __LINE__, [klass description]);
    
    NSString *className = [NSString stringWithUTF8String: class_getName(klass) ];
    
    if ([self.runtimeAddedClasses containsObject: className]) {
        return;
    }
    
    if ( self.mappingProvider == nil) {
// Если объекта нет - создать (нужного типа)
        self.mappingProvider = [InCodeMappingProvider new];
    } else if ( ! [self.mappingProvider isKindOfClass:[InCodeMappingProvider class]]) {
// Если объект существует и он НЕ нужного типа - остановить работу в методе
        NSLog(@"%s, LINE:%d, can't work with such kind of mapping provider: %@", __PRETTY_FUNCTION__, __LINE__, [[self.mappingProvider class] description]);
        return;
    }
    
    InCodeMappingProvider *selfMappingProvider = self.mappingProvider;
    [self populatePropertyMappingProvider:selfMappingProvider     forClass:klass];
    [self populateDatePropertyMappingProvider:selfMappingProvider forClass:klass];
    
    [self.runtimeAddedClasses addObject:className];
}

- (void)populatePropertyMappingProvider:(InCodeMappingProvider *)mappingProvider forClass:(Class)class {
    
    if ([class conformsToProtocol:@protocol(PropertiesMappingProvider)]) {
        
        NSArray *propertiesProvidersList = ((id (*)(id, SEL))objc_msgSend)(class, @selector(propertyProvidersList));
        
        for (PropertyProvider *provider in propertiesProvidersList) {
            
            Class propertyClass = provider.objectType;
            if (propertyClass != nil) {
                [mappingProvider mapFromDictionaryKey:provider.dictionaryKey toPropertyKey:provider.propertyName withObjectType:propertyClass forClass:class];
                continue;
            }
            
            MappingTransformer transformer = provider.transformer;
            if (transformer) {
                [mappingProvider mapFromDictionaryKey:provider.dictionaryKey toPropertyKey:provider.propertyName forClass:class withTransformer:transformer];
                continue;
            }
            
            [mappingProvider mapFromDictionaryKey:provider.dictionaryKey toPropertyKey:provider.propertyName forClass:class];
        }
    }
}

- (void)populateDatePropertyMappingProvider:(InCodeMappingProvider *)dateMappingProvider forClass:(Class)class {
    
    if ([class conformsToProtocol:@protocol(DatePropertiesMappingProvider)]) {
        
        NSArray *propertiesProvidersList = ((id (*)(id, SEL))objc_msgSend)(class, @selector(datePropertyProvidersList));
        
        for (DateFormatterProvider *provider in propertiesProvidersList) {
            
            [dateMappingProvider setDateFormatter:provider.dateFormatter forPropertyKey:provider.propertyName andClass:class];
        }
    }
}

@end
