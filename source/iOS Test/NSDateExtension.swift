//
//  NSDateExtension.swift
//  iOS Test
//
//  Created by Michael Kaminowitz on 10/20/16.
//  Copyright © 2016 Michael Kaminowitz. All rights reserved.
//

import Foundation

extension NSDate {
    func timeDifference() -> String {
        let deltaSeconds = fabs(timeIntervalSinceNow);
        let deltaMinutes = deltaSeconds / 60.0;

        if(deltaSeconds < 60)
        {
            let seconds = Int(floor(deltaSeconds))
            return ("\(seconds)s");
        }
        else if (deltaMinutes < 60)
        {
            let minutes = Int(floor(deltaMinutes))
            return "\(minutes)m"
        }
        else if (deltaMinutes < (24 * 60))
        {
            let hours = Int(floor(deltaMinutes/60))
            return "\(hours)h"
        }
        else if (deltaMinutes < (24 * 60 * 7))
        {
            let days = Int(floor(deltaMinutes/(60 * 24)))
            return "\(days)d"
        }
        else if (deltaMinutes < (24 * 60 * 31))
        {
            let weeks = Int(floor(deltaMinutes/(60 * 24 * 7)))
            return "\(weeks)w"
        }
        else if (deltaMinutes < (24 * 60 * 365.25))
        {
            let months = Int(floor(deltaMinutes/(60 * 24 * 30)))
            return "\(months)mo"
        }
        let years = Int(floor(deltaMinutes/(60 * 24 * 365)))
        return "\(years)y"
    }

    func timeDifferenceInDays() -> String {
        let deltaSeconds = fabs(timeIntervalSinceNow);
        let deltaMinutes = deltaSeconds / 60.0;

        if(deltaSeconds < 60)
        {
            let seconds = Int(floor(deltaSeconds))
            return ("\(seconds)s");
        }
        else if (deltaMinutes < 60)
        {
            let minutes = Int(floor(deltaMinutes))
            return "\(minutes)m"
        }
        else if (deltaMinutes < (24 * 60))
        {
            let hours = Int(floor(deltaMinutes/60))
            return "\(hours)h"
        }
        else
        {
            let days = Int(floor(deltaMinutes/(60 * 24)))
            return "\(days)d"
        }
    }

    func daySuffix() -> String {
        let calendar = NSCalendar.currentCalendar()
        let dayOfMonth = calendar.component(.Day, fromDate: self)
        switch dayOfMonth {
        case 1: fallthrough
        case 21: fallthrough
        case 31: return "st"
        case 2: fallthrough
        case 22: return "nd"
        case 3: fallthrough
        case 23: return "rd"
        default: return "th"
        }
    }
    
    class func recentOFDates(date1 date1: NSDate, date2: NSDate) -> NSDate {
        if date1.compare(date2) == .OrderedDescending {
            return date1
        }
        return date2
    }
    
}
