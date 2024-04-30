//
//  Event.swift
//  CalendarApp
//
//  Created by Wooseok on 4/25/24.
//

import SwiftUI

struct Event {
    let eventType: EventType
    let content: String
    let period: [Day]
    let color: Color
    let fontColor: Color
}
