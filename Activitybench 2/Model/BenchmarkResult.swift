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
    @Published var accuracy: Double
    @Published var inferenceTime: Double
    @Published var batteryConsumption: Float
    
    init(accuracy: Double, inferenceTime: Double, batteryConsumption: Float) {
        self.accuracy = accuracy
        self.inferenceTime = inferenceTime
        self.batteryConsumption = batteryConsumption
    }
    
    convenience init() {
        self.init(accuracy: 0, inferenceTime: 0, batteryConsumption: 0)
    }
}
