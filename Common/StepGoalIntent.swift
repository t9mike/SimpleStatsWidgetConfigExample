import AppIntents
struct StepGoalIntent: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource = "Step Goal Configuration"
    static var description = IntentDescription("Choose your daily step target")

    @Parameter(title: "Goal")
    var goal: StepGoalEntity?
    
}
