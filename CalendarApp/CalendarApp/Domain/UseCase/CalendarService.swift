//
//  CalendarUseCase.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

struct CalendarService {
    func fetchToday() -> Day {
        let currentDate = Date()
        return Day(date: currentDate)!
    }
    
    func fetchYear(year: Int) -> [Day]{
        var yearlyDays: [Day] = []
        var daysInYear = 0
        
        for month in 1...12 {
            guard let daysInMonth = daysInMonth(month, forYear: year) else {
                continue
            }
            daysInYear += daysInMonth
        }
        for day in 1...daysInYear {
            if let date = getDate(forDayOfYear: day, inYear: year),
               let dayObject = Day(date: date) {
               yearlyDays.append(dayObject)
            }
        }
        return yearlyDays
    }
    
    func fetchYear() -> [Day] {
        return fetchYear(year: getCurrentYear())
    }
    
    private func getCurrentYear() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        return currentYear
    }

    private func getDate(forDayOfYear dayOfYear: Int, inYear year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.day = dayOfYear
        
        guard let date = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        return date
    }

    private func daysInMonth(_ month: Int, forYear year: Int) -> Int? {
        guard let date = DateComponents(calendar: Calendar.current, year: year, month: month).date else {
            return nil
        }
        return Calendar.current.range(of: .day, in: .month, for: date)?.count
    }

    private func dayOfYear(_ day: Int, inMonth month: Int, forYear year: Int) -> Int {
        var dayOfYear = day
        for i in 1..<month {
            if let daysInMonth = daysInMonth(i, forYear: year) {
                dayOfYear += daysInMonth
            }
        }
        return dayOfYear
    }
}
