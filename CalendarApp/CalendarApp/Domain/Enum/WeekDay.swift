//
//  WeekDay.swift
//  CalendarApp
//
//  Created by Wooseok on 4/25/24.
//
import Foundation

enum WeekDay: String {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case none
    
    static let WeekDayList = [WeekDay.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    var shortName: String {
        switch self {
        case .sunday:
            "SUN"
        case .monday:
            "MON"
        case .tuesday:
            "TUE"
        case .wednesday:
            "WED"
        case .thursday:
            "THU"
        case .friday:
            "FRI"
        case .saturday:
            "SAT"
        case .none:
            "NONE"
        }
    }
    
    var subsequence: Int {
        switch self {
        case .sunday: 1
        case .monday: 2
        case .tuesday: 3
        case .wednesday: 4
        case .thursday: 5
        case .friday: 6
        case .saturday: 7
        case .none: 0
        }
    }
}
