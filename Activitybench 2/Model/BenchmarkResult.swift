//
//  BenchmarkResult.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation

class BenchmarkResult: ObservableObject {
    /// - Tag: Benchmark results
    // - accuracy
    // - inference time
    // - battery consumption
    // - battery consumption time
    // - brightness
    @Published var accuracy: Double
    @Published var inferenceTime: Double
    @Published var batteryConsumption: Float
    @Published var batteryConsumptionTime: Double
    @Published var isBrightnessMax: Bool
    
    init(accuracy: Double, inferenceTime: Double, batteryConsumption: Float, batteryConsumptionTime: Double, isBrightnessMax: Bool) {
        self.accuracy = accuracy
        self.inferenceTime = inferenceTime
        self.batteryConsumption = batteryConsumption
        self.batteryConsumptionTime = batteryConsumptionTime
        self.isBrightnessMax = isBrightnessMax
    }
    
    convenience init() {
        self.init(accuracy: 0, inferenceTime: 0, batteryConsumption: 0, batteryConsumptionTime: 0, isBrightnessMax: false)
    }
}
