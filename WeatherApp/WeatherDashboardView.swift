//
//  ContentView.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import SwiftUI
import CoreLocation

struct WeatherDashboardView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var forcastViewModel:ForecastViewModel
    @ObservedObject var location:LocationManager
    
    init() {
        let location = LocationManager()
        self.location = location
        self.weatherViewModel = WeatherViewModel(locationManager: location)
        self.forcastViewModel = ForecastViewModel(locationManager: location)
        self.location.isCalled = true
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {
                    
                    Text(weatherViewModel.city)
                        .font(.system(size: 35, weight: .semibold))
                    
                    Text(weatherViewModel.condition)
                        .font(.system(size: 20, weight: .medium))
                    
                    Text("\(weatherViewModel.temprature)°")
                        .font(.system(size: 50, weight: .semibold))
                    
                    HStack {
                        Text("H: \(weatherViewModel.maxTemp)°")
                        Text("L: \(weatherViewModel.minTemp)°")
                    }.font(.system(size: 20, weight: .medium))
                    Spacer()
                    
                }
                .foregroundColor(.white)
                
                if (forcastViewModel.isError == true) {
                    Text(forcastViewModel.errorMessage)
                        .font(.system(size: 15, weight: .medium))
                }
                
                ForEach(forcastViewModel.forecasts, id: \.id) { result in
                    VStack {
                        let condition = result.weather.map() {$0.main}
                        
                        NavigationLink(
                            destination: DetailedWeatherView(detailedWeather: result, condition: condition[0]),
                            label: {
                                HStack {
                                    let temp = result.weather.map() {$0.main}
                                    let dayOfWeek = forcastViewModel.setDate(dt: result.dt)
                                    if dayOfWeek == forcastViewModel.setDate(dt: weatherViewModel.dt) {
                                        
                                        Text("Today")
                                            .foregroundColor(.white)
                                            .frame(width: 105, alignment: .leading)
                                            .padding(.leading)
                                    }
                                    else {
                                        Text(dayOfWeek)
                                            .foregroundColor(.white)
                                            .frame(width: 105, alignment: .leading)
                                            .padding(.leading)
                                    }
                                    
                                    Spacer()
                                    
                                    setImageCondition(condition: temp[0])
                                    
                                    Spacer()
                                    Text("\(Int(result.temp.day))")
                                        .foregroundColor(.white)
                                        .padding(.trailing)
                                    Text("\(Int(result.temp.min))")
                                        .foregroundColor(Color("lightGray"))
                                        .padding(.trailing)
                                }
                            })

                        .padding(.bottom, 5)
                    }
                    
                }
            }.background(
                CurrentWeatherView(condition: weatherViewModel.condition)
            )
            .font(.system(size: 20))
            
            
        }

    }
    
  
    
    
    func setImageCondition(condition:String) -> Image {
        switch condition {
        case "Clouds" :
            return Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
        case "Rain" :
            return Image(systemName: "cloud.bolt.rain.fill")
                .renderingMode(.original)
        case "Clear" :
            return Image(systemName: "sun.max.fill")
                .renderingMode(.original)
        case "Snow" :
            return Image(systemName: "cloud.snow.fill")
                .renderingMode(.original)
        case "Mist" :
            return Image(systemName: "cloud.snow.fill")
                .renderingMode(.original)
        default:
            return Image(systemName: "cloud.bolt.rain")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDashboardView()
    }
}
