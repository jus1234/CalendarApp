//
//  CalendarHeader.swift
//  CalendarApp
//
//  Created by Wooseok on 4/29/24.
//

import SwiftUI

struct CalendarHeader: View {
    @Binding var nowMonth: Month?
    @Binding var nowYear: Int?
    
    var body: some View {
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
    }
}

//#Preview {
//    CalendarHeader()
//}
