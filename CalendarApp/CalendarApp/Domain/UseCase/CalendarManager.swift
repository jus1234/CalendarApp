//
//  CalendarViewModel.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

@Observable class CalendarManager {
    private let calendarService = CalendarService()
    var dayList: [Day]
    var toDay: Day
    var lastYear: Int = 0
    var firstYear: Int = 0
    var events: [[Int]: Event] = [:]
    
    init() {
        self.dayList = calendarService.fetchYear()
        self.toDay = calendarService.fetchToday()
        lastYear = toDay.year
        firstYear = toDay.year
        setToday()
        loadEvents()
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

extension CalendarManager {
    private func loadEvents() {
        events = [
            [1, 5, 2024]: Event(eventType: .holiday,
                                content: "노동자의 날",
                                period: [Day(date: 1, weekDay: .wednesday, month: .may, year: 2024)],
                                color: .red,
                                fontColor: .white),
            [5, 5, 2024]: Event(eventType: .holiday,
                                content: "어린이날",
                                period: [Day(date: 5, weekDay: .sunday, month: .may, year: 2024)],
                                color: .red,
                                fontColor: .white),
            [6, 5, 2024]: Event(eventType: .holiday,
                                content: "어린이날 대체 휴일",
                                period: [Day(date: 6, weekDay: .monday, month: .may, year: 2024)],
                                color: .red,
                                fontColor: .white),
            [21, 5, 2024]: Event(eventType: .custom,
                                 content: "이름이 좀 긴 삼일짜리 일정",
                                 period: [Day(date: 21, weekDay: .tuesday, month: .may, year: 2024),
                                          Day(date: 22, weekDay: .wednesday, month: .may, year: 2024),
                                          Day(date: 23, weekDay: .thursday, month: .may, year: 2024)],
                                 color: .cyan,
                                 fontColor: .white),
            [22, 5, 2024]: Event(eventType: .custom,
                                 content: "이름이 좀 긴 삼일짜리 일정",
                                 period: [Day(date: 21, weekDay: .tuesday, month: .may, year: 2024),
                                          Day(date: 22, weekDay: .wednesday, month: .may, year: 2024),
                                          Day(date: 23, weekDay: .thursday, month: .may, year: 2024)],
                                 color: .cyan,
                                 fontColor: .white),
            [23, 5, 2024]: Event(eventType: .custom,
                                 content: "이름이 좀 긴 삼일짜리 일정",
                                 period: [Day(date: 21, weekDay: .tuesday, month: .may, year: 2024),
                                          Day(date: 22, weekDay: .wednesday, month: .may, year: 2024),
                                          Day(date: 23, weekDay: .thursday, month: .may, year: 2024)],
                                 color: .cyan,
                                 fontColor: .white),
            [17, 5, 2024]: Event(eventType: .custom,
                                 content: "주말 낀 일정",
                                 period: [Day(date: 17, weekDay: .friday, month: .may, year: 2024),
                                          Day(date: 18, weekDay: .saturday, month: .may, year: 2024),
                                          Day(date: 19, weekDay: .sunday, month: .may, year: 2024),
                                          Day(date: 20, weekDay: .monday, month: .may, year: 2024)],
                                 color: .green,
                                 fontColor: .white),
            [18, 5, 2024]: Event(eventType: .custom,
                                 content: "주말 낀 일정",
                                 period: [Day(date: 17, weekDay: .friday, month: .may, year: 2024),
                                          Day(date: 18, weekDay: .saturday, month: .may, year: 2024),
                                          Day(date: 19, weekDay: .sunday, month: .may, year: 2024),
                                          Day(date: 20, weekDay: .monday, month: .may, year: 2024)],
                                 color: .green,
                                 fontColor: .white),
            [19, 5, 2024]: Event(eventType: .custom,
                                 content: "주말 낀 일정",
                                 period: [Day(date: 17, weekDay: .friday, month: .may, year: 2024),
                                          Day(date: 18, weekDay: .saturday, month: .may, year: 2024),
                                          Day(date: 19, weekDay: .sunday, month: .may, year: 2024),
                                          Day(date: 20, weekDay: .monday, month: .may, year: 2024)],
                                 color: .green,
                                 fontColor: .white),
            [20, 5, 2024]: Event(eventType: .custom,
                                 content: "주말 낀 일정",
                                 period: [Day(date: 17, weekDay: .friday, month: .may, year: 2024),
                                          Day(date: 18, weekDay: .saturday, month: .may, year: 2024),
                                          Day(date: 19, weekDay: .sunday, month: .may, year: 2024),
                                          Day(date: 20, weekDay: .monday, month: .may, year: 2024)],
                                 color: .green,
                                 fontColor: .white),
            [15, 5, 2024]: Event(eventType: .holiday,
                                content: "부처님 오신 날",
                                 period: [Day(date: 15, weekDay: .wednesday, month: .may, year: 2024)],
                                color: .red,
                                fontColor: .white)]
    }
}
