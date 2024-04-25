//
//  TabBarView.swift
//  CalendarApp
//
//  Created by Wooseok on 4/25/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            Text("Second View")
               .tabItem {
                   Label("Memo", systemImage: "folder")
               }
        }
    }
}

#Preview {
    TabBarView()
}
