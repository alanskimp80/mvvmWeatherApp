//
//  HourlyWeatherView.swift
//  Weather
//
//  Created by Anan K. Mallik on 13/08/20.
//  Copyright © 2020 Skimp Co.. All rights reserved.
//

import SwiftUI

struct HourlyWeatherView: View {
    let data: [ForecastWeather]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(data) { data in
                    HourlyWeatherCellView(data: data)
                    Spacer().frame(width: 24)
                }
            }.padding(.horizontal, 24)
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(data: [ForecastWeather.emptyInit()])
    }
}
