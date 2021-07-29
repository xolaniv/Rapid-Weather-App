//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import Foundation

struct ForecastResponse:Codable {
    let cod: String?
    let list:[Forecast]

    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case list = "list"
    }

}
