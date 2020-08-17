//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anan K. Mallik on 13/08/20.
//  Copyright © 2020 Skimp Co.. All rights reserved.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    let client = OpenweatherAPIClient()

    var stateView: StateView = StateView.loading {
        willSet {
            objectWillChange.send()
        }
    }

    var currentWeather = CurrentWeather.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }
    
    var todayWeather = ForecastWeather.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }

    var hourlyWeathers: [ForecastWeather] = [] {
        willSet {
            objectWillChange.send()
        }
    }

    var dailyWeathers: [ForecastWeather] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentDescription = "" {
        willSet {
            objectWillChange.send()
        }
    }
        
    private var stateCurrentWeather = StateView.loading
    private var stateForecastWeather = StateView.loading
    //private let cityId = "2964574" // Dublin
    private let cityId = "5368361" // Los Angeles
    //private let cityId = "3529947" //Mexico
    //private let cityId = "2643743" //London
    
    init() {
        getData()
    }
    
    func retry() {
        stateView = .loading
        stateCurrentWeather = .loading
        stateForecastWeather = .loading
        
        getData()
    }
    
    private func getData() {
        client.getCurrentWeather(at: cityId) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            if let currentWeather = currentWeather {
                ws.currentWeather = currentWeather
                ws.todayWeather = currentWeather.getForecastWeather()
                ws.currentDescription = currentWeather.description()
                ws.stateCurrentWeather = .success
            } else {
                ws.stateCurrentWeather = .failed
            }
            ws.updateStateView()
        }

        client.getForecastWeather(at: cityId) { [weak self] forecastWeatherResponse, error in
            guard let ws = self else { return }
            if let forecastWeatherResponse = forecastWeatherResponse {
                ws.hourlyWeathers = forecastWeatherResponse.list
                ws.dailyWeathers = forecastWeatherResponse.dailyList
                ws.stateForecastWeather = .success
            } else {
                ws.stateForecastWeather = .failed
            }
            ws.updateStateView()
        }
    }
        
    private func updateStateView() {
        if stateCurrentWeather == .success, stateForecastWeather == .success {
            stateView = .success
        }
        
        if stateCurrentWeather == .failed, stateForecastWeather == .failed {
            stateView = .failed
        }
    }
}
