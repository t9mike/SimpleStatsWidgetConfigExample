import WidgetKit
import AppIntents
import Foundation

enum WaterFrequency: String, CaseIterable, AppEnum {
    static var typeDisplayRepresentation = TypeDisplayRepresentation("Water Reminder Frequency")
    
    static var caseDisplayRepresentations: [WaterFrequency : DisplayRepresentation] =
    [
        .OneHour: .init(title: "Every hour"),
        .TwoHours: .init(title: "Every 2 hours"),
        .ThreeHours: .init(title: "Every 3 hours"),
    ]
    
    case OneHour
    case TwoHours
    case ThreeHours
}

extension WaterFrequency {
    func label() -> LocalizedStringResource {
        WaterFrequency.caseDisplayRepresentations[self]?.title ?? ""
    }
}
