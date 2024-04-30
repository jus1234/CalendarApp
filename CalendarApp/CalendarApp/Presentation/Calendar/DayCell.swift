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
    let event: Event?

    var body: some View {
        VStack {
            Text("\(day.date)")
                .foregroundStyle(isToday ? .white : setDateColor(day.weekDay))
                .background(isToday ? .blue : .white, in: .circle)
                .font(.system(size: 13))
                .bold()
                .padding(.vertical, 10)
            
            if let event,
               let eventFirstDay = event.period.first,
               eventFirstDay.year == day.year,
               eventFirstDay.month == day.month,
               eventFirstDay.date == day.date
            {
                GeometryReader { geometryProxy in
                    Text(event.content)
                        .padding(.leading, 0)
                        .font(.caption)
                        .foregroundStyle(event.fontColor)
                        .frame(width: UIScreen.main.bounds.width / 7 * CGFloat(calculateEventLength(event: event)), height: 15)
                        .clipShape(.buttonBorder)
                        .background(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2, style: .continuous)
                                .fill(event.color)
                                .frame(width: UIScreen.main.bounds.width / 7 * CGFloat(calculateEventLength(event: event)), height: 15)
                        }
                }
            } else if 
                let event,
                day.weekDay == .sunday
            {
                GeometryReader { geometryProxy in
                    Text(event.content)
                        .padding(.leading, 0)
                        .font(.caption)
                        .foregroundStyle(event.fontColor)
                        .frame(width: UIScreen.main.bounds.width / 7 * CGFloat(calculateSundayEventLength(event: event)), height: 15)
                        .clipShape(.buttonBorder)
                        .background(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2, style: .continuous)
                                .fill(event.color)
                                .frame(width: UIScreen.main.bounds.width / 7 * CGFloat(calculateSundayEventLength(event: event)), height: 15)
                        }
                }
            }
            
            Spacer()
        }
        .frame(height: 100)
    }
    
    private func setDateColor(_ weekDay: WeekDay) -> Color {
        if let event,
           event.eventType == .holiday 
        {
            return .red
        }
        switch weekDay {
        case .sunday:
            return .red
        case .saturday:
            return .blue
        default:
            return .black
        }
    }
    
    private func calculateEventLength(event: Event) -> Int {
        if let eventLastDay = event.period.last,
           eventLastDay.weekDay != .saturday,
           event.period.filter({ $0.weekDay == .saturday }).count > 0
        {
            return event.period.count - eventLastDay.weekDay.subsequence
        }
        
        return event.period.count
    }
    
    private func calculateSundayEventLength(event: Event) -> Int {
        guard
            let eventLastDay = event.period.last
        else {
            return 0
        }
        return eventLastDay.weekDay.subsequence
    }
}


//#Preview {
//    DayCell()
//}
