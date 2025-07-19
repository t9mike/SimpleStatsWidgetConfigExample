import WidgetKit
import SwiftUI
import Foundation

struct WaterReminderEntry: TimelineEntry {
    let date: Date
    let configuration: WaterReminderIntent
}

struct WaterReminderProvider: AppIntentTimelineProvider {
    func recommendations() -> [AppIntentRecommendation<WaterReminderIntent>] {
        return []
    }
    
    
    func placeholder(in context: Context) -> WaterReminderEntry {
        .init(date: .now, configuration: .sample)
    }

    func snapshot(for configuration: WaterReminderIntent, in context: Context) async -> WaterReminderEntry {
        .init(date: .now, configuration: configuration)
    }

    func timeline(for configuration: WaterReminderIntent, in context: Context) async -> Timeline<WaterReminderEntry> {
        .init(entries: [.init(date: .now, configuration: configuration)], policy: .never)
    }
    
}

extension WaterReminderIntent {
    static var sample: WaterReminderIntent {
        let intent = WaterReminderIntent()
        intent.frequency = .OneHour
        return intent
    }
}

struct WaterReminderWidgetView: View {
    let entry: WaterReminderEntry

    var body: some View {
        VStack {
            Text("💧 Water Reminder")
            Text(entry.configuration.frequency?.label() ?? "")
                .font(.footnote)
        }
        .padding()
    }
}

struct WaterReminderWidget: Widget {
    
    let kind = "WaterReminderWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: WaterReminderIntent.self, provider: WaterReminderProvider()) { entry in
            WaterReminderWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Water Reminder")
        .description("Set your hydration frequency.")
        #if os(ios)
        .supportedFamilies([.systemMedium, .systemLarge]) // ✅ Medium & Large only
        #else
        .supportedFamilies([.accessoryRectangular, .accessoryCircular])
        #endif
    }
    
}

#if os(iOS)
#Preview(as: .systemSmall) {
    WaterReminderWidget()
} timeline: {
    WaterReminderEntry(date: .now, configuration: .sample)
}
#endif

