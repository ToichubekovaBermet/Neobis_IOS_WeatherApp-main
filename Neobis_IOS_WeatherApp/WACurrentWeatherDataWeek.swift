//
//  WACurrentWeatherDataWeek.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 10/9/23.
//
import Foundation

// MARK: - WACurrentWeatherDataWeek
struct WACurrentWeatherDataWeek: Codable {
    let cod: String
    let message, cnt: Int
    let list: ListForWeek
    let city: CityName
}

// MARK: - City
struct CityName: Codable {
    let id: Int
    let name: String
    let coord: CoordForWeek
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct CoordForWeek: Codable {
    let lat, lon: Double
}

// MARK: - List
struct ListForWeek: Codable {
    let dt: Int
    let main: MainForWeek
    let weather: [WeatherForWeek]
    let clouds: CloudsForWeek
    let wind: WindForWeek
    let visibility: Int
    let pop: Double
    let rain: RainForWeek?
    let sys: SysForWeek
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct CloudsForWeek: Codable {
    let all: Int
}

// MARK: - Main
struct MainForWeek: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct RainForWeek: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct SysForWeek: Codable {
    let pod: String
}

// MARK: - Weather
struct WeatherForWeek: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct WindForWeek: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
