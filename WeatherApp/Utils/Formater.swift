//
//  Formater.swift
//  WeatherApp
//
//  Xolani by Admin on 2021/07/29.
//

import Foundation

struct Formater {
    
    func setDate(dt:Int) -> String {
        let weekDay:String
        let date:Double = Double(dt)
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        weekDay = unixConvertedDate.dayOfTheWeek()
        return weekDay
    }
    
    func setTime(dt:Int) -> String {
        let weekDay:String
        let date:Double = Double(dt)
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        weekDay = unixConvertedDate.time()
        return weekDay
    }
}

