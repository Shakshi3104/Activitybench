//
//  AccelerometerManager.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import UIKit
import CoreMotion
import CoreML
import ProcessorKit

class AccelerometerManager {
    /// - Tag: input of activity classifier
    // - window length for prediction
    // - acceleration data for prediction
    private let predictionWindowLength = 256 * 3
    private var predictionData = [Double]()
    
    // CMMotionManager
    private var motionManager = CMMotionManager()
    // Timer
    private var timer: Timer!
    
    /// - Tag: activity classifier
    private var model: UnifiedMLModel!
    
    /// - Tag: Performance
    /// - Inference time
    /// - CPU total usage
    /// - CPU app usage (% CPU)
    private var predictionTimes = [Double]()
    private var totalUsages = [Double]()
    private var coreUsages = [[Double]]()
    private var appUsages = [Float]()
    
    init() {
        print("init AccelerometerManager")
    }
    
    /// Processing when the sensor data value is acquired
    @objc private func acquireData() {
        if let data = motionManager.accelerometerData {
            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            
            predictionData.append(x)
            predictionData.append(y)
            predictionData.append(z)
        } else {
            // for macOS
            for _ in 1...3 {
                predictionData.append(Double.random(in: -2.0 ..< 2.0))
            }
        }
        
        // predict activity
        if predictionData.count == predictionWindowLength {
            guard let predictionDataMLMultiArray = try? MLMultiArray.fromDouble(predictionData) else {
                fatalError("Couldn't initialize MLMultiArray from Double array")
            }
            
            // measure inference time
            let startTime = Date()
            
            // predict
            guard let output = try? model.prediction(input: predictionDataMLMultiArray) else {
                fatalError()
            }
            
            let finishTime = Date()
            let predictionTime = finishTime.timeIntervalSince(startTime)
            
            predictionTimes.append(predictionTime)
            
            // CPU load
            let deviceUsage = CPU.systemUsage()
            let coreUsage = CPU.coreUsage()
            let appUsage = CPU.appUsage()
            print("⚙️ system: \(deviceUsage.system), user: \(deviceUsage.user)")
            print("⚙️ % CPU: \(appUsage)")
            
            totalUsages.append(deviceUsage.system + deviceUsage.user)
            
            let coreTotalUsage = coreUsage.map { $0.system + $0.user }
            coreUsages.append(coreTotalUsage)
            print("⚙️ each core: ")
            let _ = coreTotalUsage.map { print("💎 \($0)") }
            
            appUsages.append(appUsage)
            
            print("\(output.classLabel) (\(output.Identity[output.classLabel] ?? 0))")
            
            // init predictionData
            predictionData.removeAll()
        }
    }
    
    /// Start measuring sensor data
    func startUpdate(_ frequency: Double, model: UnifiedMLModel) {
        self.model = model
        
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0 / frequency,
                                          target: self,
                                          selector: #selector(self.acquireData),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    /// Stop measuring sensor data
    func stopUpdate() -> (predictionTime: Double,
                          totalUsage: Double,
                          coreUsage: [Double],
                          percentCPU: Float) {
        self.timer.invalidate()
        
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
        
        predictionData.removeAll()
        
        // summrize benchmark
        /// Latency
        let predictionTime = predictionTimes.count != 0 ? predictionTimes.reduce(0, +) / Double(predictionTimes.count) : 0
        /// CPU load (All)
        let totalUsage = totalUsages.count != 0 ? totalUsages.reduce(0, +) / Double(totalUsages.count) : 0
        /// % CPU
        let percentCPU = appUsages.count != 0 ? appUsages.reduce(0, +) / Float(appUsages.count) : 0
        /// Each Core load
        let coreUsage = coreUsages.count != 0 ? (0..<coreUsages.first!.count).map { index in
            coreUsages.map { usage in
                usage[index]
            }
            .reduce(0, +)
            / Double(coreUsages.count)
        } : Array(repeating: 0.0, count: DeviceInfo.shared.cpuCount)
        
        predictionTimes.removeAll()
        totalUsages.removeAll()
        appUsages.removeAll()
        coreUsages.removeAll()
        
        return (predictionTime,
                totalUsage,
                coreUsage,
                percentCPU)
    }
}
