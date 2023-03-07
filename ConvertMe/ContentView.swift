//
//  ContentView.swift
//  ConvertMe
//
//  Created by Maximilian Berndt on 2023/03/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fromTemperature: TemperatureUnit = TemperatureUnit.Celsius
    @State private var toTemperature: TemperatureUnit = TemperatureUnit.Fahrenheit
    @State private var temperature: Double = 32.0
    
    enum TemperatureUnit: String, CaseIterable {
        case Celsius
        case Kelvin
        case Fahrenheit
    }
    
    // only 1 unit was required to be converted in this project. Let's keep it simple but I might add it later
    enum LengthUnit: String {
        case Kilometers
        case Feet
        case Yard
        case Miles
    }
    
    enum TimeUnit: String {
        case Seconds
        case Minutes
        case Hours
        case Days
    }
    
    enum VolumeUnit: String {
        case Milliliters
        case Liters
        case Cups
        case Pints
        case Gallons
    }

    private func temperatureConversion(
        value: Double,
        from: TemperatureUnit,
        to: TemperatureUnit
    ) -> Double {
        switch (from, to) {
        case (.Celsius, .Kelvin): return temperature + 273.15
        case (.Kelvin, .Celsius): return temperature - 273.15
        case (.Celsius, .Fahrenheit): return (temperature * 9 / 5) + 32
        case (.Fahrenheit, .Celsius): return (temperature - 32) * 5 / 9
        case (.Kelvin, .Fahrenheit): return ((temperature - 273.15) * 9 / 5) + 32
        case (.Fahrenheit, .Kelvin): return ((temperature - 32) * 5 / 9) + 273.15
        default: return temperature
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Convert From", selection: $fromTemperature) {
                    ForEach(TemperatureUnit.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
                Picker("Convert To", selection: $toTemperature) {
                    ForEach(TemperatureUnit.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
            } header: {
                Text("Temperature Conversion")
            }
            Section {
                TextField("Temperature", value: $temperature, format: .number)
            } header: {
                Text("Original Temperature")
            }
            Section {
                Text(temperatureConversion(
                    value:temperature,
                    from: fromTemperature,
                    to: toTemperature
                ), format: .number)
            } header: {
                Text("Converted Temperature")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
