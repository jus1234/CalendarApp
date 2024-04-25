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
    @State private var tappedDayId: Day.ID?
    
    init() {
        dayId = viewModel.toDay.id
        nowYear = viewModel.toDay.year
        nowMonth = viewModel.toDay.month
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("TODAY")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                Spacer()
                Text("\(nowMonth?.name ?? "") \(String(nowYear ?? 0))")
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
                    .bold()
                Spacer()
                    Image(systemName: "square.grid.3x3.square")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                .padding(.trailing, 30)
                Image(systemName: "line.horizontal.3")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 10)
            
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { i in
                    Text(WeekDay.WeekDayList[i].shortName)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width / 7)
                }
            }
            
        
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
                                        if $1.count < 1{
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
                                    .onTapGesture {
                                        tappedDayId = day.id
                                    }
                                    
                                Rectangle()
                                    .fill(.gray)
                                    .opacity(tappedDayId == day.id ? 0.2 : 0.0)
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .onAppear {
                        dayId = viewModel.toDay.id
                        tappedDayId = viewModel.toDay.id
                        scrollViewProxy.scrollTo(dayId)
                    }
                }
            }
            .scrollPosition(id: $dayId, anchor: .center)
            .scrollIndicators(.hidden)
            .background(.white)
            
        }
        .background(.indigo)
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
                .foregroundStyle(isToday ? .white : setDateColor(day.weekDay))
                .background(isToday ? .blue : .white, in: .circle)
                .font(.system(size: 13))
                .bold()
            Text("\(day.year)")
                .padding(.horizontal, 5)
                .font(.caption)
            Text("\(day.month.rawValue)")
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
