//
//  Location.swift
//  SpeedMeter
//
//  Created by Haruya Ishikawa on 2024/03/11.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

@Observable
class Location: NSObject, CLLocationManagerDelegate {
    var speedKmh: Double = .zero
    var speedAccuracyKmh: Double = .zero
    var averageSpeedKmh: Double = .zero
    var headingDegree: Double = .zero
    
    private let locationManager = CLLocationManager()
    private var startTime: Date?
    private var previousLocation: CLLocation?
    private var distance: Double = 0
    private var speedsKmh: [Double] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func resetValues() {
        startTime = nil
        previousLocation = nil
        distance = .zero
        speedsKmh = []
        speedKmh = .zero
        averageSpeedKmh = .zero
        headingDegree = .zero
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if (location.speed >= 0) {
            speedKmh = location.speed * 3.6
            speedAccuracyKmh = location.speedAccuracy * 3.6
            
            if let previousLocation = previousLocation {
                distance += location.distance(from: previousLocation)
                let timeInterval = location.timestamp.timeIntervalSince(previousLocation.timestamp)
                let speedKmh = 3.6 * distance / timeInterval
                speedsKmh.append(speedKmh)
                let averageSpeedKmh = speedsKmh.reduce(0, +) / Double(speedsKmh.count)
                self.averageSpeedKmh = averageSpeedKmh
            }
            
            previousLocation = location
            if startTime == nil {
                startTime = Date()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingDegree = newHeading.trueHeading
    }
    
    func cardinalValue(from heading: CLLocationDirection) -> String {
        switch heading {
        case 0 ..< 22.5:
            return "北"
        case 22.5 ..< 67.5:
            return "北東"
        case 67.5 ..< 112.5:
            return "東"
        case 112.5 ..< 157.5:
            return "南東"
        case 157.5 ..< 202.5:
            return "南"
        case 202.5 ..< 247.5:
            return "南西"
        case 247.5 ..< 292.5:
            return "西"
        case 292.5 ..< 337.5:
            return "北西"
        case 337.5 ... 360.0:
            return "北"
        default:
            return ""
        }
    }
}
