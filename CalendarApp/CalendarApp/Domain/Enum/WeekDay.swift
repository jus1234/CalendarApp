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
}
