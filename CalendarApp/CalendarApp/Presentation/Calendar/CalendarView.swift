//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Wooseok on 4/20/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject private var viewModel = CalendarViewModel()
    @State private var dayId: Day.ID?
    @State private var isFirstLoad: Bool = true
    @State private var nowYear: Int?
    @State private var nowMonth: Month?
    @State private var nowPresentedDays: [Day] = []
    
    init() {
        dayId = viewModel.toDay.id
        nowYear = viewModel.toDay.year
        nowMonth = viewModel.toDay.month
    }
    
    var body: some View {
        VStack {
            Text("\(nowYear ?? 0) \(nowMonth?.rawValue ?? 0)")
            
            ScrollView(.vertical) {
                ScrollViewReader { scrollViewProxy in
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
                        ForEach(viewModel.dayList) { day in
                            ZStack {
                                DayCell(nowYear: $nowYear, 
                                        nowMonth: $nowMonth,
                                        day: day,
                                        isToday: Day.isSame(lhs: day, rhs: viewModel.toDay))
                                    .id(day.id)
                                    .onAppear {
                                        if day.month == .january && day.year == viewModel.firstYear && !isFirstLoad {
                                            dayId = day.id
                                            viewModel.fetchPreviousYear()
                                        }
                                        if day.month == .december && day.year == viewModel.lastYear && !isFirstLoad {
                                            dayId = day.id
                                            viewModel.fetchAfterYear()
                                        }
                                        if day.id == dayId {
                                            isFirstLoad = false
                                        }
                                        nowPresentedDays.append(day)
                                    }
                                    .onDisappear {
                                        nowPresentedDays = nowPresentedDays.filter { !Day.isSame(lhs: day, rhs: $0) }
                                    }
                                    .onChange(of: nowPresentedDays) {
                                        if $1.count <= 20 {
                                            return
                                        }
                                        var yearDictionary: [Int: Int] = [:]
                                        var monthDictionary: [Month: Int] = [:]
                                        $1.forEach { day in
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
                                    .opacity(nowYear == day.year && nowMonth == day.month ? 1.0 : 0.5)
                                    
                                Rectangle()
                                    .fill(.gray)
                                    .opacity(Day.isSame(lhs: day, rhs: viewModel.toDay) ? 0.2 : 0.0)
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .onAppear {
                        dayId = viewModel.toDay.id
                        scrollViewProxy.scrollTo(dayId)
                    }
                }
            }
            .frame(height: 600)
            .scrollPosition(id: $dayId, anchor: .center)
            .scrollIndicators(.hidden)
            
        }
    }
    
}

struct DayCell: View {
    @Binding var nowYear: Int?
    @Binding var nowMonth: Month?
    let day: Day
    let isToday: Bool

    var body: some View {
        VStack {
            Text("\(day.date)")
                .foregroundStyle(setDateColor(day.weekDay))
                .bold()
            Text("\(day.year)")
                .padding(.horizontal, 5)
                .font(.caption)
            Text("\(day.month.rawValue)")
                .padding(.horizontal, 5)
                .font(.caption)
            Text("\(day.weekDay.rawValue)")
                .padding(.horizontal, 5)
                .font(.caption)
        }
        .frame(height: 100)
    }
    
    private func setDateColor(_ weekDay: WeekDay) -> Color {
        switch weekDay {
        case .sunday:
            return .red
        case .saturday:
            return .blue
        default:
            return .black
        }
    }
}

#Preview {
    CalendarView()
}
