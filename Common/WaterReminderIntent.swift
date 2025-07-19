import AppIntents

struct WaterReminderIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Water Reminder Configuration"
    static var description = IntentDescription("Set how often you want to be reminded to drink water")

    @Parameter(title: "Frequency")
    var frequency: WaterFrequency?
}
