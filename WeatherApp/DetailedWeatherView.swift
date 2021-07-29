//
//  DetailedWeatherView.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/27.
//

import SwiftUI

struct DetailedWeatherView: View {
    @State private var isNight:Bool = true
    
    var detailedWeather:Forecast
    var condition:String
    
    var body: some View {
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            ScrollView {
                VStack {
                    HStack {
                        
                        if (condition == "Rain"){
                        Image(systemName: "cloud.bolt.rain.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                        }
                        else if condition == "Clear" {
                            Image(systemName: "sun.max.fill")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        else if condition == "Clouds" {
                            Image(systemName: "cloud.sun.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        else if condition == "Drizzle" {
                            Image(systemName: "cloud.drizzle.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        
                        else if condition == "Snow" {
                            Image(systemName: "thermometer.snowflake")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        
                        else if condition == "Thunderstorm" {
                            Image(systemName: "cloud.bolt.rain.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        
                        
                        VStack {
                            Text("\(setDate(dt:detailedWeather.dt))")
                                .font(.system(size: 30))
                        }
                        
                    }.foregroundColor(.white)
                    
                   
                    
                    Text("\(Int(detailedWeather.temp.day))°")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(condition)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    HStack {
                        
                        Text("L: \(Int(detailedWeather.temp.min))°")
                        Text("H: \(Int(detailedWeather.temp.max))°")
                        
                    }.font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    
                    Divider()
                        .foregroundColor(.white)
                    
                    VStack(alignment:.leading) {
                        Text("Sunrise")
                            .foregroundColor(Color("lightGray"))
                            .font(.system(size: 15))
                        
                        Text("\(setTime(dt: detailedWeather.sunrise))")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("Sunset")
                            .foregroundColor(Color("lightGray"))
                            .font(.system(size: 15))
                        
                        Text("\(setTime(dt: detailedWeather.sunset))")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                        
                    }
                        
                    Divider()
                    
                    VStack {
                        Text("Humidity")
                            .foregroundColor(Color("lightGray"))
                            .font(.system(size: 15))
                            
                        Text("\(Int(detailedWeather.humidity)) %")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    
                }
                Divider()
                
                VStack() {
                    Text("Pressure")
                        .foregroundColor(Color("lightGray"))
                        .font(.system(size: 15))
                    
                    Text("\(Int(detailedWeather.pressure)) hPa")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                    
                }
                
            }
        }
    }
   
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

struct WeatherIcon: View {
    var condition = ""
    
    var body: some View {
        Image(systemName: self.returnBackgroundImage(codition: condition))
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        
    }
    
    enum BackgrounColor:String {
        case Clear = "Clear"
        case Rainy = "Rain"
        case Clouds = "Clouds"
        case Drizzle = "Drizzle"
        case Snow = "Snow"
        case Thunderstorm = "hunderstorm"
        
        }
    
    enum BackgrounImage:String {
        case Clear = "sun.max.fill"
        case Rainy = "cloud.rain.fill"
        case Clouds = "cloud.sun.fill"
        case Drizzle = "cloud.drizzle.fill"
        case Snow = "thermometer.snowflake"
        case Thunderstorm = "cloud.bolt.rain.fill"
        
       }
    
    func returnBackgroundImage(codition:String) -> String {
          switch (codition){
          case "Clear" :
              return BackgrounImage.Clear.rawValue
          case "Rain":
              return BackgrounImage.Rainy.rawValue
          case "Clouds":
              return BackgrounImage.Clouds.rawValue
          case "Drizzle":
              return BackgrounImage.Drizzle.rawValue
          case "Snow":
              return BackgrounImage.Snow.rawValue
          case "Thunderstorm":
              return BackgrounImage.Thunderstorm.rawValue
            
          default:
              return BackgrounImage.Clear.rawValue
          }
      
      }

}



struct BackgroundView: View {
    @Binding var isNight:Bool
    

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")] ),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

//struct DetailedWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailedWeatherView(detailedWeather: .init(id: 0, dt: 0988, sunrise: 9, temp: 7, humidity: 9, weather: [WeatherInfo]))
//    }
//}
