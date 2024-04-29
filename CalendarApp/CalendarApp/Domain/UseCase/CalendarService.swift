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
        guard
            let today = Day(date: currentDate)
        else {
            return Day(date: 1, weekDay: .none, month: .january, year: 0)
        }
        return today
    }
    
    func fetchYear(year: Int) -> [Day]{
        var yearlyDays: [Day] = []
        var daysInYear = 0
        
        for month in 1...12 {
            guard 
                let daysInMonth = daysInMonth(month, forYear: year)
            else {
                continue
            }
            daysInYear += daysInMonth
        }
        
        for day in 1...daysInYear {
            guard
                let date = getDate(forDayOfYear: day, inYear: year),
                let dayObject = Day(date: date)
            else {
               continue
            }
            yearlyDays.append(dayObject)
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
    
        guard 
            let date = Calendar.current.date(from: dateComponents)
        else {
            return nil
        }
        
        return date
    }

    private func daysInMonth(_ month: Int, forYear year: Int) -> Int? {
        guard 
            let date = DateComponents(calendar: Calendar.current, year: year, month: month).date
        else {
            return nil
        }
        
        return Calendar.current.range(of: .day, in: .month, for: date)?.count
    }

    private func dayOfYear(_ day: Int, inMonth month: Int, forYear year: Int) -> Int {
        var dayOfYear = day
        
        for i in 1..<month {
            guard 
                let daysInMonth = daysInMonth(i, forYear: year) 
            else {
                continue
            }
            dayOfYear += daysInMonth
        }
        
        return dayOfYear
    }
}
