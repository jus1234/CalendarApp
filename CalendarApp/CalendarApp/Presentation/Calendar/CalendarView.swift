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
    
    init() {
        dayId = viewModel.toDay.id
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { scrollViewProxy in
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
                        ForEach(viewModel.dayList) { day in
                            DayCell(day: day)
                                .id(day.id)
                                .onAppear {
                                    if day.month == .january && day.year == viewModel.firstYear && !isFirstLoad {
                                        dayId = day.id
                                        viewModel.fetchPreviousYear()
                                    }
                                    if day.month == .december && day.year == viewModel.lastYear {
                                        dayId = day.id
                                        viewModel.fetchAfterYear()
                                    }
                                    if day.id == dayId {
                                        isFirstLoad = false
                                    }
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
            .scrollPosition(id: $dayId)
            .scrollIndicators(.hidden)
            
        }
    }
    
}

struct DayCell: View {
    let day: Day

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
        .frame(height: 140)
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
