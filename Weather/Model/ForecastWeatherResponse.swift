//
//  ForecastWeatherResponse.swift
//  Weather
//
//  Created by Anan K. Mallik on 13/08/20.
//  Copyright © 2020 Skimp Co.. All rights reserved.
//

import Foundation

struct ForecastWeatherResponse: Codable {
    let code: String
    let message, count: Int
    let list: [ForecastWeather]
    let city: ForecastWeatherCity
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list, city
    }
    
    static func emptyInit() -> ForecastWeatherResponse {
        return ForecastWeatherResponse(
            code: "",
            message: 0,
            count: 0,
            list: [],
            city: ForecastWeatherCity.emptyInit()
        )
    }
    
    var dailyList: [ForecastWeather] {
        var result: [ForecastWeather] = []
        guard var before = list.first else {
            return result
        }
        
        if before.date.dateFromMilliseconds().dayWord() != Date().dayWord() {
            result.append(before)
        }

        for weather in list {
            if weather.date.dateFromMilliseconds().dayWord() != before.date.dateFromMilliseconds().dayWord() {
                result.append(weather)
            }
            before = weather
        }

        return result
    }
}
