//
//  WACurrentWeather.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 3/9/23.
//

import Foundation
struct WACurrentWeather {
    let cityName: String
    let country: String
    let timezone: Int
    let pressureStatus: Int
    let visibilityStatus : Double
    let humidityStatus : Int
    let windStatus: Int
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)

        
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 700...781: return "cloud.fog.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData: WACurrentWeatherData) {
        self.cityName = currentWeatherData.name
        self.country = currentWeatherData.sys.country
        self.timezone = currentWeatherData.timezone
        self.temperature = currentWeatherData.main.temp
        self.conditionCode = currentWeatherData.weather.first?.id ?? 0
        self.pressureStatus = currentWeatherData.main.pressure
        self.visibilityStatus = Double(currentWeatherData.visibility)
        self.humidityStatus = currentWeatherData.main.humidity
        self.windStatus = Int(currentWeatherData.wind.speed)
    }
}

