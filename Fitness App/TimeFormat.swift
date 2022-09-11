//
//  TimeFormat.swift
//  Fitness App
//
//  Created by Ian Hill on 9/9/22.
//

import Foundation

extension Date {
    func calcTimeSince() -> String {
        let minutes = Int(-self.timeIntervalSinceNow)/60
        let hours = minutes/60
        let days = hours/24
        
        if minutes < 120 {
            return "\(minutes) minutes ago"
        } else if minutes >= 120 && hours < 48 {
            return "\(hours) hours ago"
        } else {
            return "\(days) days ago"
        }
    }
}
