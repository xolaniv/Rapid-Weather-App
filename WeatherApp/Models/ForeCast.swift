//
//  ForeCast.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import Foundation


struct Forecast:Codable,Identifiable {
    var id = UUID()
    var dt:Int
    var sunrise:Int
    var sunset:Int
    
    var temp:Temprature
    var humidity:Int
    var weather:[WeatherInfo]
    var pressure:Int
    var speed : Double
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case temp = "temp"
        case humidity = "humidity"
        case weather = "weather"
        case pressure = "pressure"
        case speed = "speed"
        case sunset = "sunset"

    }
}

struct Temprature:Codable {
    var day:Double
    var min:Double
    var max:Double
    
    
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        
    }
}

struct WeatherInfo: Codable,Identifiable {
    var id:Int
    var main: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        
    }
}
