import SwiftUI
import WidgetKit

@main
struct SimpleStatsWidgetsBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        
        StepGoalWidget()
        WaterReminderWidget()

    }
}
