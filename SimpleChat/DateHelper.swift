//
//  DateHelper.swift
//  SimpleChat
//
//  Created by jason debottis on 11/11/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import Foundation
class DateHelper{
    
    public static func dateFromMilliseconds(ms: NSNumber) -> Date {
        return Date(timeIntervalSince1970: Double(ms) / 1000)
    }
    
    public static func getStringFromDate(dateIn: Date) ->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "E - h:mm:s a"
        return dateFormat.string(from: dateIn)
    }
}
