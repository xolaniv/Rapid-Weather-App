//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/25.
//

import Foundation
import Alamofire
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var condition = "loading...."
    @Published var temprature = 0
    @Published var feel_like = 0
    @Published var minTemp = 0
    @Published var maxTemp = 0
    @Published var humidity = 0
    @Published var city = ""
    @Published var dt = 0
    
    @Published var errorMessage = ""
    var isError = false
    
    var locationManager = LocationManager()
    
    private var cancelables = Set<AnyCancellable>()
    
    var latitude: String {
        return "\(locationManager.location?.coordinate.latitude ?? 0.0)"
        
    }
    var longitude: String {
        return "\(locationManager.location?.coordinate.longitude ?? 0.0)"
        
    }
    @Published var loading = false
    
    
    let headers:HTTPHeaders = [
        "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
        "X-RapidAPI-Key": "\(Keys.apiKey)"
    ]
    
    private var subscriber: AnyCancellable?
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager

        // listen for available location explicitly
        subscriber = locationManager.$location
//            .debounce(for: 5, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard location != nil else { return }
                self?.getCurrentWeather()
            }
    }
    
    init() {
        
    }
    
    func getCurrentWeather() {
        
  
        
        let url = BaseURL.production + "/weather?lon=\(longitude)&lat=\(latitude)&units=metric"
        
        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
            if response.error == nil {
                
                let result = try! JSONDecoder().decode(WeatherResponse.self, from: response.data!)
                DispatchQueue.main.async {
                    
                    self.temprature = Int(result.main.temp)
                    self.feel_like  = Int(result.main.feels_like)
                    self.minTemp = Int(result.main.temp_min)
                    self.maxTemp = Int(result.main.temp_max)
                    self.humidity = result.main.humidity
                    self.city = result.name
                    self.dt = result.dt
                    result.weather.forEach { condition in
                        self.condition = condition.main
                    }
                    print("Called")
                    
                }
                
            }
            else {
                print(response.error!)
                
            }
            
        }
        self.locationManager.isCalled = true
        locationManager.isCalled = true
    }
}
