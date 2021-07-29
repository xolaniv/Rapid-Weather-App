//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            WeatherDashboardView()
        }
    }
}
