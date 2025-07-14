import WidgetKit
import SwiftUI
import Foundation

struct StepGoalEntry: TimelineEntry {
    let date: Date
    let configuration: StepGoalIntent
}

struct StepGoalProvider: AppIntentTimelineProvider {
    func recommendations() -> [AppIntentRecommendation<StepGoalIntent>] {
        return []
    }
    
    func placeholder(in context: Context) -> StepGoalEntry {
        .init(date: .now, configuration: .sample)
    }
    

    func snapshot(for configuration: StepGoalIntent, in context: Context) async -> StepGoalEntry {
        StepGoalEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: StepGoalIntent, in context: Context) async -> Timeline<StepGoalEntry> {
        let entry = StepGoalEntry(date: Date(), configuration: configuration)
        return Timeline(entries: [entry], policy: .never)
    }
    
}

extension StepGoalIntent {
    static var sample: StepGoalIntent {
        let intent = StepGoalIntent()
        intent.goal = StepGoalEntity(id: "10000", label: "10,000 steps")
        return intent
    }
}

struct StepGoalWidgetView: View {
    var entry: StepGoalEntry

    var body: some View {
        VStack {
            Text("🎯 Step Goal")
                .font(.headline)
            Text(entry.configuration.goal?.label ?? "")
                .font(.title3)
        }
        .padding()
    }
}

struct StepGoalWidget: Widget {

    let kind = "StepGoalWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: StepGoalIntent.self, provider: StepGoalProvider()) { entry in
            StepGoalWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Step Goal")
        .description("Your daily step target.")
        #if os(watchOS)
        .supportedFamilies([.accessoryCircular, .accessoryRectangular]) // ✅ Only small size
        #else
        .supportedFamilies([.systemSmall]) // ✅ Only small size
        #endif
    }

}

#if os(ios)
#Preview(as: .systemSmall) {
    StepGoalWidget()
} timeline: {
    StepGoalEntry(date: .now, configuration: .sample)
}
#endif
