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
    @Published var cpuLoad: Double
    @Published var coreLoad: [Double]
    
    init(accuracy: Double, inferenceTime: Double, cpuLoad: Double, coreLoad: [Double]) {
        self.accuracy = accuracy
        self.inferenceTime = inferenceTime
        self.cpuLoad = cpuLoad
        self.coreLoad = coreLoad
    }
    
    convenience init() {
        self.init(accuracy: 0, inferenceTime: 0, cpuLoad: 0, coreLoad: Array(repeating: 0, count: DeviceInfo.shared.cpuCount))
    }
}
