//
//  WeatherClouds.swift
//  Weather
//
//  Created by Anan K. Mallik on 13/08/20.
//  Copyright © 2020 Skimp Co.. All rights reserved.
//

import Foundation

struct WeatherClouds: Codable {
    let all: Int

    static func emptyInit() -> WeatherClouds {
        return WeatherClouds(all: 0)
    }
}
