//
//  Day.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

struct Event {
    let content: String
    let startTime: String // 우선 순위
    let period: [Day]
//    let icon
//    let color: Color
}

struct Day: Identifiable {
    let id: UUID = UUID()
    let date: Int
    let weekDay: WeekDay
    let month: Month
    let year: Int
}

enum WeekDay: String {
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
              let year = components.year else {
            return nil
        }

        let weekday = Calendar.current.component(.weekday, from: date)
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
    
    static func isSame(lhs: Day, rhs: Day) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.date == rhs.date
    }
}
