//
//  Month.swift
//  CalendarApp
//
//  Created by Wooseok on 4/25/24.
//

enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    var name: String {
        switch self {
        case .january:
            "January"
        case .february:
            "February"
        case .march:
            "March"
        case .april:
            "April"
        case .may:
            "May"
        case .june:
            "June"
        case .july:
            "July"
        case .august:
            "August"
        case .september:
            "September"
        case .october:
            "October"
        case .november:
            "November"
        case .december:
            "December"
        }
    }
}
