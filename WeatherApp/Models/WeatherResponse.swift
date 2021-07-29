//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import Foundation


struct WeatherResponse:Decodable {
    let timezone:Int
    let name:String
    let weather: [Weather]
    let main: Main
//    let sys:Sys
    let dt:Int
    

//    struct Weather:Decodable {
//        let main:String
//    }
    
}
struct Weather:Decodable {
    let main:String
}

struct Main:Codable {
    let temp:Double
    let humidity:Int
    let temp_min:Double
    let temp_max:Double
    let feels_like:Double
    
    
}

struct Sys:Decodable {
    let country:String
    
}
