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
        guard var previousYear: Int = dayList.first?.year else {
            return
        }
        previousYear -= 1
        dayList = calendarService.fetchYear(year: previousYear) + dayList
    }
    
    func fetchAfterYear() {
        lastYear += 1
        guard var afterYear: Int = dayList.last?.year else {
            return
        }
        afterYear += 1
        dayList = dayList + calendarService.fetchYear(year: afterYear)
    }
    
    private func setToday() {
        toDay = dayList.filter { Day.isSame(lhs: toDay, rhs: $0) }[0]
    }
}
