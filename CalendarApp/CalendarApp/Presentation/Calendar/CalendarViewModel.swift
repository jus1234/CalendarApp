//
//  CalendarViewModel.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

class CalendarViewModel: ObservableObject {
    private let calendarService = CalendarService()
    @Published var dayList: [Day]
    var toDay: Day
    var lastYear: Int
    var firstYear: Int
    
    init() {
        self.dayList = calendarService.fetchYear()
        self.toDay = calendarService.fetchToday()
        self.lastYear = toDay.year
        self.firstYear = toDay.year
        setToday()
    }
    
    func fetchPreviousYear() {
        firstYear -= 1
        dayList = attachPreviousDays(days: calendarService.fetchYear(year: firstYear) + dayList.filter { $0.year > firstYear })
    }
    
    func fetchAfterYear() {
        lastYear += 1
        dayList = dayList + calendarService.fetchYear(year: lastYear)
    }
    
    private func setToday() {
        guard 
            let targetDay = dayList.filter({ Day.isSame(lhs: toDay, rhs: $0) }).first
        else {
            return
        }
        toDay = targetDay
        dayList = attachPreviousDays(days: dayList)
    }
    
    private func attachPreviousDays(days: [Day]) -> [Day] {
        var dayList = [WeekDay.sunday, .monday, .tuesday, .wednesday, .thursday, .friday]
        var comparableWeekDayList = [WeekDay.monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        var previousDays: [Day] = []
        var date = 31
        while !dayList.isEmpty {
            guard 
                let weekDay = dayList.popLast(),
                let firstDay = previousDays.count > 0 ? previousDays.first : days.first,
                let comparableDay = comparableWeekDayList.popLast()
            else {
                return days
            }
            if firstDay.weekDay == .sunday {
                break
            }
            if firstDay.weekDay == comparableDay {
                previousDays = [Day(date: date, weekDay: weekDay, month: .december, year: firstYear - 1)] + previousDays
            }
            date -= 1
        }
        return previousDays + days
    }
}
