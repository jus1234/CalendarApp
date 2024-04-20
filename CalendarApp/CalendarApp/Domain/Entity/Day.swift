//
//  Day.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

struct Day {
    let date: Int
    let weekDay: WeekDay
    let month: Month
}

enum WeekDay {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

enum Month {
    case january
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
