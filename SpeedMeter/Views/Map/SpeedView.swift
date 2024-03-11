//
//  SpeedView.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/11.
//

import SwiftUI

struct SpeedView: View {
    @Environment(Location.self) var location
    let plusMinus = "\u{00B1}"
    let speedColor: Color = .accentColor
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(String(format: "%.1f", location.speedKmh))
                    .foregroundColor(speedColor)
                    .font(.system(size: 100, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text("km/h")
                    .font(.title2)
                
                Text("誤差: \(plusMinus)\(location.speedAccuracyKmh, specifier: "%.2f") km/h")
                    .font(.caption)
            }
            Spacer()
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    SpeedView()
        .environment(Location())
}
