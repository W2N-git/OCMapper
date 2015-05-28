//
//  ObjectMapper+Private.h
//  Pods
//
//  Created by Anton Belousov on 27/05/15.
//
//

#ifndef Pods_ObjectMapper_Private_h
#define Pods_ObjectMapper_Private_h
#import "ObjectMapper.h"
@interface ObjectMapper (private)
- (id)processDictionary:(NSDictionary *)source forClass:(Class)class;
@end
#endif
