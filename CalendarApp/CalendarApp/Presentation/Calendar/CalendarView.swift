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
    @State private var toDayId: Day.ID?
    
    init() {
        toDayId = viewModel.toDay.id
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { scrollViewProxy in
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
                        ForEach(viewModel.dayList) { day in
                            DayCell(day: day)
                                .onAppear {
                                    if day.month == .january && day.year == viewModel.firstYear && !isFirstLoad {
                                        viewModel.fetchPreviousYear()
                                        dayId = day.id
                                    }
                                    if day.month == .december && day.year == viewModel.lastYear {
                                        viewModel.fetchAfterYear()
                                        dayId = day.id
                                    }
                                }
                                .id(day.id)
                        }
                        
                    }
                    .scrollTargetLayout()
                    .background(
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                scrollViewProxy.scrollTo(toDayId)
                                isFirstLoad.toggle()
                            }
                        }
                    )
                }
            }
            .frame(height: 600)
            .scrollPosition(id: $dayId)
            
            //GeometryReader
            // 다른 달 다르게 표시
            
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
