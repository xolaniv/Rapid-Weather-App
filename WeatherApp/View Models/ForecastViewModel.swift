//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Xolani on 2021/07/25.
//

import Foundation
import Alamofire
import Combine

class ForecastViewModel: ObservableObject {
    @Published var forecasts = [Forecast]()
    @Published var temprature = ""
    
    @Published var errorMessage = ""
    var isError = false
    
    private var subscriber: AnyCancellable?
    private var locationManager: LocationManager
    
    
    
    let headers:HTTPHeaders = [
        "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
        "X-RapidAPI-Key": "\(Keys.apiKey)"
    ]
    
    
    var latitude: String {
        return "\(locationManager.location?.coordinate.latitude ?? 0.0)"
        
    }
    var longitude: String {
        return "\(locationManager.location?.coordinate.longitude ?? 0.0)"
        
    }
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager

        // listen for available location explicitly
        subscriber = locationManager.$location
//            .debounce(for: 5, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard location != nil else { return }
                self?.getForecast()
            }
    }
    
    
    func getForecast() {

        let url = BaseURL.production + "forecast/daily?lon=\(longitude)&lat=\(latitude)&units=metric"
        
        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
            if response.error == nil {
                let result = try! JSONDecoder().decode(ForecastResponse.self, from: response.data!)
                if result.cod == "200" {
                    DispatchQueue.main.async {
                        self.forecasts = result.list
                        print("Called Focast")
                        
                    }
                }
                else if result.cod == "400" {
                    self.isError = true
                    self.errorMessage =  "Someting Went wrong"
                }
                
                
            }
            
            else {
                self.isError = true
                self.errorMessage = "\(String(describing: response.error?.localizedDescription))"
                print("\(response.error!)")
                
            }
            
        }
        self.locationManager.isCalled = true
        
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
}
