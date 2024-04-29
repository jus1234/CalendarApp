//
//  EventCell.swift
//  CalendarApp
//
//  Created by Wooseok on 4/28/24.
//

import SwiftUI

struct EventCell: View {
    private var startDay: Day
    private var events: [Event] = []
    
    init(startDay: Day) {
        self.startDay = startDay
    }
    
    var body: some View {
        Text("점심 식사와 저녁식사와 야식")
            .font(.caption)
            .background {
                Rectangle()
                    .fill(.yellow)
            }
    }
}

//#Preview {
//    EventCell()
//}
