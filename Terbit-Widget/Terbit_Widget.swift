//
//  Terbit_Widget.swift
//  Terbit-Widget
//
//  Created by Umar Abdul Azis on 15/05/25.
//

import WidgetKit
import SwiftUI
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let isDone: Bool
    let streak: [Date]
}

struct Provider: AppIntentTimelineProvider {
    let streakManager = StreakManagerWidget()
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(
            date: Date(),
            configuration: ConfigurationAppIntent(),
            isDone: streakManager.isTodayStreak,
            streak: streakManager.streakDates
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WidgetEntry {
        return WidgetEntry(
            date: Date(),
            configuration: configuration,
            isDone: streakManager.isTodayStreak,
            streak: streakManager.streakDates
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WidgetEntry> {
        let entry = WidgetEntry(
            date: Date(),
            configuration: configuration,
            isDone: streakManager.isTodayStreak,
            streak: streakManager.streakDates
        )
        return Timeline(entries: [entry], policy: .never)
    }

}


struct Terbit_WidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
                
        default:
            EmptyView()
        }
    }
}

struct Terbit_Widget: Widget {
    let kind: String = "Terbit_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Terbit_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct Terbit_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Terbit_Widget()
    }
}
