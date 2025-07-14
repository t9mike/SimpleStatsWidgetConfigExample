import WidgetKit
import AppIntents
import Foundation

struct WaterFrequencyEntity: AppEntity, Identifiable {
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Water Reminder Frequency")
    static var defaultQuery = WaterFrequencyStringQuery()

    var id: String
    var label: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(label)")
    }
    
}

struct WaterFrequencyStringQuery: EntityStringQuery {
    
    func entities(matching string: String) async throws -> [WaterFrequencyEntity] {
        try await fetchFrequencies().filter { $0.label.localizedCaseInsensitiveContains(string) }
    }

    func entities(for identifiers: [String]) async throws -> [WaterFrequencyEntity] {
        try await fetchFrequencies().filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() async throws -> [WaterFrequencyEntity] {
        try await fetchFrequencies()
    }

    func defaultResult() async -> WaterFrequencyEntity? {
        try? await fetchFrequencies().first
    }

    private func fetchFrequencies() async throws -> [WaterFrequencyEntity] {
        [
            WaterFrequencyEntity(id: "1h", label: "Every 1 Hour"),
            WaterFrequencyEntity(id: "2h", label: "Every 2 Hours"),
            WaterFrequencyEntity(id: "3h", label: "Every 3 Hours")
        ]
    }
    
}
