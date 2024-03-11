//
//  SpeedMeterApp.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/10.
//

import SwiftUI

@main
struct SpeedMeterApp: App {
    @State private var location = Location()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(location)
        }
    }
}
