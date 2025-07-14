import AppIntents
struct StepGoalEntity: AppEntity, Identifiable {
    
    var id: String
    var label: String
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Step Goal")
    static var defaultQuery = StepGoalQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(label)")
    }
    
}


struct StepGoalQuery: EntityStringQuery {
    
    func entities(matching string: String) async throws -> [StepGoalEntity] {
        try await fetchGoals().filter { $0.label.localizedCaseInsensitiveContains(string) }
    }

    func entities(for identifiers: [String]) async throws -> [StepGoalEntity] {
        try await fetchGoals().filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() async throws -> [StepGoalEntity] {
        try await fetchGoals()
    }

    func defaultResult() async -> StepGoalEntity? {
        try? await fetchGoals().first
    }

    private func fetchGoals() async throws -> [StepGoalEntity] {
        [
            StepGoalEntity(id: "1000", label: "1000 steps"),
            StepGoalEntity(id: "10000", label: "10000 steps"),
            StepGoalEntity(id: "15000", label: "15000 steps")
        ]
    }
    
}
