//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Anan K. Mallik on 13/08/20.
//  Copyright © 2020 Skimp Co.. All rights reserved.
//

import SwiftUI

struct DailyWeatherView: View {
    let data: [ForecastWeather]
    
    var body: some View {
        VStack {
            ForEach(data, id: \.date) { data in
                DailyWeatherCellView(data: data)
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(data: [ForecastWeather.emptyInit()])
    }
}
