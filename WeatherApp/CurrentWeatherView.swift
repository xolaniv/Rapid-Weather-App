//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Xolani on 2021/07/29.
//

import SwiftUI

struct CurrentWeatherView: View {
    var condition = ""
    
    var body: some View {
        Image(self.returnBackgroundImage(codition: condition))
            .edgesIgnoringSafeArea(.all)
    }
    
    enum BackgrounColor:String {
            case Clear = "Clear"
            case Rainy = "Rain"
            case Cloudy = "Clouds"
        }
    
    enum BackgrounImage:String {
           case Clear = "ClearImage"
           case Rainy = "rain"
           case Cloudy = "clouds"
       }
    
    func returnBackgroundImage(codition:String) -> String {
          switch (codition){
          case "Clear" :
              return BackgrounImage.Clear.rawValue
          case "Rain":
              return BackgrounImage.Rainy.rawValue
          case "Clouds":
              return BackgrounImage.Cloudy.rawValue
          default:
              return BackgrounImage.Clear.rawValue
          }
      
      }

}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
