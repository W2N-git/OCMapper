//
//  ObjectMapper+Private.h
//  Pods
//
//  Created by Anton Belousov on 27/05/15.
//
//

#import "OCMapper.h"
@interface ObjectMapper (private__)
- (id)processDictionary:(NSDictionary *)source forClass:(Class)class;
@end

