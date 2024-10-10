//
//  Model.swift
//  Wheater APP
//
//  Created by Jianji Zhong Huang on 6/10/24.
//

import Foundation

struct Model: Decodable {
    var city: String
    var weather: [Weather]
    var main: Main
    var windSpeed: Wind
    
    static let empty: Model = .init(
        city: "No city",
        weather: [Weather(main: "Unknown", description: "No description", icon: "no-icon")],
        main: Main(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, humidity: 0.0),
        windSpeed: Wind(speed: 0.0)
    )
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather = "weather"
        case main = "main"
        case windSpeed = "wind"
    }
    
    struct Weather: Decodable {
        var main: String
        var description: String
        var icon: String
        
        enum CodingKeys: String, CodingKey {
            case main
            case description
            case icon
        }
    }
    
    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }
    
    struct Wind: Decodable {
        var speed: Double
        
        enum CodingKeys: String, CodingKey {
            case speed
        }
    }
}

struct WheaterModelMapper {
    func mapDataModel(dataModel: Model) -> Model {
        guard !dataModel.city.isEmpty, dataModel.main.temp != 0
        else {
            return .empty
        }
        return Model(city: dataModel.city, weather: dataModel.weather, main: dataModel.main, windSpeed: dataModel.windSpeed)
    }
}

/* JSON del API
{
 "id": 3163858,
 "name": "Zocca",
 "cod": 200
 ,
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "humidity": 64,
  },
  "wind": {
    "speed": 0.62,
  },
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  }
}
   */
