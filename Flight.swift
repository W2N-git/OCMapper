//
//  Flight.swift
//  TransaeroAPITester
//
//  Created by Anton Belousov on 12/05/15.
//  Copyright (c) 2015 qqqqq. All rights reserved.
//

import UIKit
import ObjectiveC

@objc
class Flight: NSObject {
    
    var arrivalAirportCode: String?
    var arrivalDate: NSDate?
    
    var departureAirportCode: String?
    var departureDate: NSDate?
    
    var bookingClassAvails: [BookingClassAvail] = []

    var airEquipType             : String?
    var departureAirportTerminal : String?
    var equipment                : String?
    var equipmentName            : String?
    var flightNumber             : String?
    var flightTime               : String?
    var marketingAirline         : String?
    var marketingCabinMeal       : String?
    var rph                      : Int    = 0
    var stopQuantity             : Int    = 0
    var ticket                   : String?

    //MARK: -
    override var description: String {
        
        if self.segments.count > 0 {
            let segmentsDescriotion = " \r".join(self.segments.map{ $0.description })
            return "RPH:\(rph) \(departureAirportCode)(\(departureDate)) -> \(arrivalAirportCode)(\(arrivalDate))" + "  \r" + "segments:\(segmentsDescriotion)"
        }
        
        let availsDescriotion = " \r".join(self.bookingClassAvails.map{ $0.description })
        
        return "RPH:\(rph) \(departureAirportCode)(\(departureDate)) -> \(arrivalAirportCode)(\(arrivalDate))" + "      \r" + "\(availsDescriotion)"
    }
    
    //MARK: -
    //MARK: Optional Runtime Properties
    var segments = [Flight]()
        {
        didSet{
            println("FUNC: \(__FUNCTION__), LINE:\(__LINE__)")
            if self.segments.count > 0 {
                println("FUNC: \(__FUNCTION__), LINE:\(__LINE__)")
                self.departureAirportCode = self.segments.first!.departureAirportCode
                self.departureDate        = self.segments.first!.departureDate

                self.arrivalAirportCode = self.segments.last!.arrivalAirportCode
                self.arrivalDate        = self.segments.last!.arrivalDate
            }
        }
    }
}

//MARK: -
@objc
class BookingClassAvail: NSObject {

    var	cabinName         : String?
    var	cabinNameEng      : String?
    var	cabinNameFra      : String?
    var	cabinNameKaz      : String?
    var	cabinNameRus      : String?

    var	cabinNameRT       : String?
    var	cabinNameRTEng    : String?
    var	cabinNameRTFra    : String?
    var	cabinNameRTKaz    : String?
    var	cabinNameRTRus    : String?

    var	rbdCode           : String?
    var	rbdQuantity       : Int     = 0
    var	rbdStatusCode     : Int     = 0
    var	rph               : Int     = 0
    
    override var description: String {
        return "\(cabinName), \(rbdCode)-\(rbdQuantity)"
    }
}



extension Flight: PropertiesMappingProvider, DatePropertiesMappingProvider {
    
    static func propertyProvidersList() -> [AnyObject] {
        return [
            PropertyProvider(dictionaryKey: "arrivalAirport",       propertyName: "arrivalAirportCode",     objectType: nil, transformer: nil),
            PropertyProvider(dictionaryKey: "departureAirport",     propertyName: "departureAirportCode",   objectType: nil, transformer: nil),
            PropertyProvider(dictionaryKey: "arrivalDateTime",      propertyName: "arrivalDate",            objectType: nil, transformer: nil),
            PropertyProvider(dictionaryKey: "departureDateTime",    propertyName: "departureDate",          objectType: nil, transformer: nil),
            
            PropertyProvider(dictionaryKey: "bookingClassAvails",   propertyName: "bookingClassAvails",     objectType: BookingClassAvail.self, transformer: nil),
        ]
    }
    static func datePropertyProvidersList() -> [AnyObject] {
        
        let dateFormatter_1 = NSDateFormatter()
        dateFormatter_1.dateFormat = "yyyy/MM/ddThh.mm.ss"
        
        return [
            DateFormatterProvider(propertyName: "departureDate",   dateFormatter: dateFormatter_1),
            DateFormatterProvider(propertyName: "arrivalDate",     dateFormatter: dateFormatter_1),
        ]
    }
}


