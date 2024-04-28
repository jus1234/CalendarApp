//
//  DayCell.swift
//  CalendarApp
//
//  Created by Wooseok on 4/28/24.
//

import SwiftUI

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
                .padding(.vertical, 10)
            Spacer()
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


//#Preview {
//    DayCell()
//}
