//
//  ContentView.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapContainer()
    }
}

#Preview {
    ContentView()
        .environment(Location())
}
