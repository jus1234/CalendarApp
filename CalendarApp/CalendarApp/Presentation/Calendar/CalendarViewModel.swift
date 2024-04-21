//
//  CalendarViewModel.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var dayList: [Day] = []
    private let calendarService = CalendarService()
    
    init() {
        fetchThisYear()
    }
    
    func fetchPreviousYear() {
        guard let previousYear: Int = dayList.first?.year else {
            return
        }
        dayList = calendarService.fetchYear(year: previousYear) + dayList
    }
    
    func fetchAfterYear() {
        guard let afterYear: Int = dayList.last?.year else {
            return
        }
        dayList = dayList + calendarService.fetchYear(year: afterYear)
    }
    
    private func fetchThisYear() {
        dayList = calendarService.fetchYear()
    }
}
