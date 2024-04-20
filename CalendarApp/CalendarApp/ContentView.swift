//
//  ContentView.swift
//  CalendarApp
//
//  Created by Wooseok on 4/16/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarListView()
                .tabItem {
                  Image(systemName: "calendar")
                  Text("Action")
                }
            
            Text("Second View")
                .tabItem {
                    Image(systemName: "folder")
                    Text("folder")
                }
        }
        .font(.headline)
    }
}

struct CalendarListView: View {
    @State private var currentDate = Date()
    
    init() {
        _currentDate = State<Date>(initialValue: Date())
    }
    
    var body: some View {
        VStack {
            // 달력의 헤더 표시
            Text("\(currentDate, formatter: dateFormatter)")
                .font(.title)
                .padding()
            
            // 달력 스크롤 뷰
            ScrollView(.vertical) {
                VStack {
                    ForEach(-6...6, id: \.self) { offset in
                        // 각 월의 날짜 표시
                        MonthView(month: Calendar.current.component(.month, from: self.currentDate))
                            .frame(height: 400)
                    }
                }
            }
            .frame(height: 600) // 달력 뷰의 높이 지정
        }
    }
    
    // 날짜 형식 지정
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }

    private func moveMonth(offset: Int) {
        currentDate = Calendar.current.date(byAdding: .month, value: offset, to: currentDate)!
    }
}

struct MonthView: View {
    let month: Int
    
    // 각 월의 첫 날을 구하는 함수
    private func firstDateOfMonth(year: Int, month: Int) -> Date {
        let components = DateComponents(year: year, month: month)
        return Calendar.current.date(from: components)!
    }
    
    // 각 월의 일수를 구하는 함수
    private func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    var body: some View {
        VStack {
            Text("\(month)월")
                .font(.headline)
            
            // 그리드 형태로 일자 표시
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
                ForEach(1..<(daysInMonth(year: Calendar.current.component(.year, from: Date()), month: month) + 1), id: \.self) { day in
                    // 각 일자 셀 표시
                    DayCell(day: day)
                }
            }
        }
    }
}

struct DayCell: View {
    let day: Int
    
    // 이벤트를 표시할 문자열 (임의의 데이터로 대체)
//    @State private var event: String = ""
    
    var body: some View {
        VStack {
            Text("\(day)")
            
            Text("이벤트")
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal, 5)
                .font(.caption)
        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .frame(height: 100)
        
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
