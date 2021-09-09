//
//  DataModel.swift
//  W&F Weather
//
//  Created by Влад on 08.09.2021.
//

import Foundation
import UIKit
var update: Bool = false
var cityData:[WeatherData] = []
var searchedCity = [WeatherData]()
var coordinate:[CitySourse] = [CitySourse(lat:55.75396, lon:37.620393),CitySourse(lat:59.9397392, lon:30.3140793),
                               CitySourse(lat:51.6719, lon:39.1803),CitySourse(lat:53.53, lon:49.35),CitySourse(lat:54.744, lon:55.97),CitySourse(lat:55.33, lon:86.08),CitySourse(lat:47.23, lon:39.72),CitySourse(lat:55.15, lon:61.43),CitySourse(lat:54.99, lon:73.37),CitySourse(lat:57.0, lon:40.97),]

var weatherImage = ["clear" : "sun",
                    "partly-cloudy" : "partly-cloudy",
                    "cloudy" : "clouds",
                    "overcast" : "rain_cloud",
                    "drizzle" : "rain",
                    "rain" : "rain",
                    "light-rain" : "rain",
                    "heavy-rain" : "rain",
                    "continuous-heavy-rain" : "rain",
                    "showers" : "rain",
                    "light-snow " : "snow",
                    "snow" : "snow",
                    "snow-showers " : "snow",
                    "hail" : "hail",
                    "thunderstorm " : "thunder",
                    "thunderstorm-with-rain" : "thunder",
                    "thunderstorm-with-hail" : "thunder"]

var weatherTranslate = ["clear" : "Ясно",
                        "partly-cloudy" : "Преимущественно облачно",
                        "cloudy" : "Облачно",
                        "overcast" : "Пасмурно",
                        "drizzle" : "Дождливо",
                        "rain" : "Дождь",
                        "light-rain" : "Легкий дождь",
                        "heavy-rain" : "Сильный дождь",
                        "continuous-heavy-rain" : "Затяжной дождь",
                        "showers" : "Ливень",
                        "light-snow " : "Небольшие снежные осадки",
                        "snow" : "Снег",
                        "snow-showers " : "Метель",
                        "hail" : "Град",
                        "thunderstorm " : "Гроза",
                        "thunderstorm-with-rain" : "Гроза с дождем",
                        "thunderstorm-with-hail" : "Гроза с градо"]
struct CitySourse{
    let lat: Float
    let lon: Float
}
struct WeatherData: Codable {
                                    
    let fact: FactWeather          //Информация о погоде сейчас
    let forecasts: [Forecast]     //Прогноз погоды
    let geo_object: GeoObject      //Информация о населенном пункте
    let now: Int64              //время сервера в Unixtime
    let now_dt: String         //время сервера в UTC
  
}

struct Forecast: Codable{
    let date: String
    let date_ts: Int64
    let moon_code: Int
    let moon_text: String
    let parts: AllForecast
    let rise_begin: String
    let set_end: String
    let sunrise: String
    let sunset: String
    let week: Int
}

struct PartForecast: Codable{
    let cloudness: Float
    let condition: String
    let daytime: String
    let feels_like: Int
    let humidity: Int
    let icon: String
    let polar: Bool
    let prec_mm: Float
    let prec_period: Int
    let prec_prob: Int
    let prec_strength: Float
    let prec_type: Int
    let pressure_mm: Float
    let pressure_pa: Float
    let temp_avg: Int
    let temp_max: Int
    let temp_min : Int
    let uv_index: Int
    let wind_dir: String
    let wind_gust: Float
    let wind_speed: Float
}

struct DayShort: Codable{
    let cloudness: Float
    let condition: String
    let daytime: String
    let feels_like: Int
    let humidity: Int
    let icon: String
    let polar: Bool
    let prec_mm: Float
    let prec_period: Int
    let prec_prob: Int
    let prec_strength: Float
    let prec_type: Int
    let pressure_mm: Float
    let pressure_pa: Float
    let temp: Int
    let temp_min : Int
    let wind_dir: String
    let wind_gust: Float
    let wind_speed: Float
}


struct NightShort: Codable{
    //let _sourse: String
    let cloudness: Float
    let condition: String
    let daytime: String
    let feels_like: Int
    let humidity: Int
    let icon: String
    let polar: Bool
    let prec_mm: Float
    let prec_period: Int
    let prec_prob: Int
    let prec_strength: Float
    let prec_type: Int
    let pressure_mm: Float
    let pressure_pa: Float
    let temp: Int
    let wind_dir: String
    let wind_gust: Float
    let wind_speed: Float
}

struct AllForecast: Codable{
    //let day: PartForecast
    let day_short:DayShort
    let evening: PartForecast
    let morning: PartForecast
    let night: PartForecast
    let night_short: NightShort
}
struct GeoObject: Codable{
    struct Place: Codable{
        let id: Int
        let name: String
    }
    let country: Place
    let district: Place?
    let locality: Place
    let province: Place
}

struct FactWeather: Codable{
    let cloudness: Float
    let condition: String
    let daytime: String
    let feels_like: Int
    let humidity: Int
    let icon: String
    let is_thunder: Bool
    let obs_time: Int64
    let polar: Bool
    let prec_prob: Float
    let prec_strength: Float
    let prec_type: Float
    let pressure_mm: Int
    let pressure_pa: Int
    let season: String
    let source: String
    let temp: Int
    let uptime: Int64
    let wind_dir: String
    let wind_gust: Float
    let wind_speed: Float
}

class AddButton: UIButton {
    var lat: String?
    var lon: String?
}
