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
        var temperature: Measurement<UnitTemperature>
        switch (from) {
        case .Celsius:
            temperature = Measurement(value: value, unit: UnitTemperature.celsius)
        case .Fahrenheit:
            temperature = Measurement(value: value, unit: UnitTemperature.fahrenheit)
        case .Kelvin:
            temperature = Measurement(value: value, unit: UnitTemperature.kelvin)
        }
        
        switch (to) {
        case .Celsius: return temperature.converted(to: .celsius).value
        case .Fahrenheit: return temperature.converted(to: .fahrenheit).value
        case .Kelvin: return temperature.converted(to: .kelvin).value
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
