//
//  WANetworkWeatherManager.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 3/9/23.
//

import Foundation
import CoreLocation

class WANetworkWeatherManager {
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }

    let apiKey = "2457cd0e53e3095c0923cb76634d5dd2"
    var onCompletion: ((WACurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType type: RequestType) {
        var stringUrl = ""
        switch type {
        case .cityName(let city):
            stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            stringUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        self.performRequest(withStringUrl: stringUrl)
    }
    
    private func performRequest(withStringUrl stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
   func parseJSON(withData data: Data) -> WACurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(WACurrentWeatherData.self, from: data)
                     return WACurrentWeather(currentWeatherData: currentWeatherData)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
//    func main() {
//        // Ваш код здесь
//        let jsonString = """
//        {
//            "dt_txt": "2022-08-30 15:00:00"
//        }
//        """
//
//        if let jsonData = jsonString.data(using: .utf8) {
//            do {
//                let date = try JSONDecoder().decode(Date.self, from: jsonData)
//                print("Дата: \(date.dtTxt)")
//            } catch {
//                print("Ошибка декодирования: \(error)")
//            }
//        } else {
//            print("Ошибка преобразования строки JSON в данные")
//        }
//    }

}

