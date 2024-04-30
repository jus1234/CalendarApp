//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var calendar = CalendarManager()
    @State private var dayId: Day.ID?
    @State private var isFirstLoad: Bool = true
    @State private var nowYear: Int?
    @State private var nowMonth: Month?
    @State private var nowPresentedDays: [Day] = []
    @State private var tappedDayId: Day.ID?
    private let mockEvents: [[Int]: Event] = [
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
                             fontColor: .white)]
    
    init() {
        dayId = calendar.toDay.id
        nowYear = calendar.toDay.year
        nowMonth = calendar.toDay.month
    }
    
    var body: some View {
        VStack {
            CalendarHeader(nowMonth: $nowMonth, nowYear: $nowYear)
            
            ZStack(alignment: .bottomLeading) {
                ScrollView(.vertical) {
                    ScrollViewReader { scrollViewProxy in
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
                            ForEach(calendar.dayList) { day in
                                ZStack {
                                    DayCell(nowYear: $nowYear,
                                            nowMonth: $nowMonth,
                                            day: day,
                                            isToday: Day.isSame(lhs: day, rhs: calendar.toDay), 
                                            event: mockEvents[[day.date, day.month.rawValue, day.year]])
                                        .onAppear {
                                            didAppeardDay(day: day)
                                        }
                                        .onDisappear {
                                            nowPresentedDays = nowPresentedDays.filter {
                                                !Day.isSame(lhs: day, rhs: $0)
                                            }
                                        }
                                        .onChange(of: nowPresentedDays) {
                                            checkNowPresentedDays(presentedDays: $1)
                                        }
                                        .opacity(nowYear == day.year && nowMonth == day.month ? 1.0 : 0.5)
                                        .onTapGesture {
                                            tappedDayId = day.id
                                        }
                                        .id(day.id)
                                        
                                    Rectangle()
                                        .fill(.gray)
                                        .opacity(tappedDayId == day.id ? 0.2 : 0.0)
                                        
                                }
                                
                            }
                        }
                        .scrollTargetLayout()
                        .onAppear {
                            dayId = calendar.toDay.id
                            tappedDayId = calendar.toDay.id
                            scrollViewProxy.scrollTo(dayId)
                        }
                    }
                }
                .scrollPosition(id: $dayId, anchor: .center)
                .scrollIndicators(.hidden)
                .background(.white)
                
                HStack {
                    Spacer()
                    
                    Button {} label: {
                        Text("New Action")
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 50,
                                    style: .continuous
                                )
                                .fill(.indigo)
                            )
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }
        .background(.indigo)
    }
    
}

extension CalendarView {
    private func checkNowPresentedDays(presentedDays: [Day]) {
        if presentedDays.count < 1{
            return
        }
        var yearDictionary: [Int: Int] = [:]
        var monthDictionary: [Month: Int] = [:]
        presentedDays.forEach { day in
            if yearDictionary[day.year] != nil {
                yearDictionary[day.year]? += 1
            } else {
                yearDictionary[day.year] = 1
            }
            if monthDictionary[day.month] != nil {
                monthDictionary[day.month]? += 1
            } else {
                monthDictionary[day.month] = 1
            }
        }
        var maxYear: Int = 0
        yearDictionary.forEach { (year, count) in
            guard
                let maxYearCount = yearDictionary[maxYear]
            else {
                maxYear = year
                return
            }
            maxYear = maxYearCount >= count ? maxYear : year
        }
        if nowYear != maxYear {
            nowYear = maxYear
        }
        var maxMonth: Month?
        monthDictionary.forEach { (month, count) in
            guard
                let maxMonthNotNil = maxMonth,
                let maxMonthCount = monthDictionary[maxMonthNotNil]
            else {
                maxMonth = month
                return
            }
            maxMonth = maxMonthCount >= count ? maxMonth : month
        }
        if nowMonth != maxMonth {
            nowMonth = maxMonth
        }
    }
    
    private func didAppeardDay(day: Day) {
        if day.month == .january && day.year == calendar.firstYear && !isFirstLoad {
            dayId = day.id
            calendar.fetchPreviousYear()
        }
        if day.month == .december && day.year == calendar.lastYear && !isFirstLoad {
            dayId = day.id
            calendar.fetchAfterYear()
        }
        if day.id == dayId {
            isFirstLoad = false
        }
        nowPresentedDays.append(day)
    }
}

//#Preview {
//    CalendarView()
//}
