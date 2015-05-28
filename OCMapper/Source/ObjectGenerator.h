//
//  ObjectGenerator+runtimeMappingProviderPopulate.h
//  ObjectMapping
//
//  Created by Anton Belousov on 27/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "ObjectMapper+Private.h"

@interface ObjectGenerator: ObjectMapper
- (void)populateMappingSelfProviderForClassIfNeeded:(Class)class;
@end
