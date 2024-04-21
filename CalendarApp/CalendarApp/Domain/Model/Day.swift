//
//  Day.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

struct Day: Identifiable {
    let id = UUID()
    let date: Int
    let weekDay: WeekDay
    let month: Month
    let year: Int
}

enum WeekDay {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case none
}

enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}

extension Day {
    init?(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .weekday, .month, .year], from: date)
        
        guard let day = components.day,
              let month = components.month,
              let year = components.year,
              let weekday = components.weekday else {
            return nil
        }
        
        let weekDay: WeekDay
        switch weekday {
            case 1: weekDay = .sunday
            case 2: weekDay = .monday
            case 3: weekDay = .tuesday
            case 4: weekDay = .wednesday
            case 5: weekDay = .thursday
            case 6: weekDay = .friday
            case 7: weekDay = .saturday
            default: weekDay = .none
        }
        
        self.init(date: day, weekDay: weekDay, month: Month(rawValue: month) ?? .january, year: year)
    }
}
