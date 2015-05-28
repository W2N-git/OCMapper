//
//  ObjectMapper_.swift
//  ObjectMapping
//
//  Created by Anton Belousov on 26/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

import Foundation

@objc
final class PropertyProvider {
    
    let dictionaryKey: String
    let propertyName: String
    let transformer: MappingTransformer?
    let objectType: AnyClass?
    
    init(dictionaryKey:String, propertyName: String? = nil, objectType: AnyClass? = nil,  transformer: MappingTransformer? = nil) {

        self.dictionaryKey = dictionaryKey
        self.propertyName  = propertyName ?? dictionaryKey
        self.objectType    = objectType
        self.transformer   = transformer
    }
}

@objc
final class DateFormatterProvider {

    let propertyName: String
    let dateFormatter: NSDateFormatter
    
    init(propertyName: String, dateFormatter: NSDateFormatter) {
        self.propertyName  = propertyName
        self.dateFormatter = dateFormatter
    }
}

@objc
protocol PropertiesMappingProvider {
    static func propertyProvidersList() -> [PropertyProvider]
}

@objc
protocol DatePropertiesMappingProvider {
    static func datePropertyProvidersList() -> [DateFormatterProvider]
}
