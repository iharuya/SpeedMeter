//
//  TopView.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/11.
//

import SwiftUI

struct Header: View {
    @Environment(Location.self) var location
    
    var headingDirection: String { location.cardinalValue(from: location.headingDegree)}

    var body: some View {
        HStack {
            Text("\(headingDirection)")
                .font(.title3)
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(width: 50, alignment: .leading)

            Spacer()

            VStack {
                Text("平均速度")
                    .font(.caption)
                HStack {
                    Text(String(format: "%.1f", location.averageSpeedKmh))
                    Text("km/h")
                }
            }
            .padding(.leading, -28)

            Spacer()

            Button(action: location.resetValues) {
                Label("リセット", systemImage: "goforward")
                    .labelStyle(.iconOnly)
            }
            .buttonStyle(.automatic)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    Header()
        .environment(Location())
}
