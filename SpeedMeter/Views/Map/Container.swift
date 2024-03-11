//
//  Map.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/10.
//

import SwiftUI
import MapKit

struct MapContainer: View {
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
        .safeAreaInset(edge: .top) {
            Header()
        }
        .safeAreaInset(edge: .bottom) {
            SpeedView()
        }
    }
}

#Preview {
    MapContainer()
        .environment(Location())
}
