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
    /// - Battery level (deprecated)
    /// - CPU system usage
    /// - CPU user usage
    /// - CPU total usage
    /// - CPU app usage (% CPU)
    private var predictionTimes = [Double]()
    private var batteryLevels = [Float]()
    private var systemUsages = [Double]()
    private var userUsages = [Double]()
    private var totalUsages = [Double]()
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
            
            let deviceUsage = CPU.systemUsage()
            let appUsage = CPU.appUsage()
            print("⚙️ system: \(deviceUsage.system), user: \(deviceUsage.user)")
            print("⚙️ % CPU: \(appUsage)")
            systemUsages.append(deviceUsage.system)
            userUsages.append(deviceUsage.user)
            totalUsages.append(deviceUsage.system + deviceUsage.user)
            appUsages.append(appUsage)
            
            let batteryLevel = UIDevice.current.batteryLevel
            batteryLevels.append(batteryLevel)
            
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
                          batteryConsumption: Float,
                          systemUsage: Double,
                          userUsage: Double,
                          totalUsage: Double,
                          percentCPU: Float) {
        self.timer.invalidate()
        
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
        
        predictionData.removeAll()
        
        let predictionTime = predictionTimes.count != 0 ? predictionTimes.reduce(0, +) / Double(predictionTimes.count) : 0
        let batteryConsumption = batteryLevels.count != 0 ? (batteryLevels.first ?? 0) - (batteryLevels.last ?? 0) : 0
        let systemUsage = systemUsages.count != 0 ? systemUsages.reduce(0, +) / Double(systemUsages.count) : 0
        let userUsage = userUsages.count != 0 ? userUsages.reduce(0, +) / Double(userUsages.count) : 0
        let totalUsage = totalUsages.count != 0 ? totalUsages.reduce(0, +) / Double(totalUsages.count) : 0
        let percentCPU = appUsages.count != 0 ? appUsages.reduce(0, +) / Float(appUsages.count) : 0
        
        predictionTimes.removeAll()
        batteryLevels.removeAll()
        systemUsages.removeAll()
        userUsages.removeAll()
        totalUsages.removeAll()
        appUsages.removeAll()
        
        return (predictionTime,
                batteryConsumption,
                systemUsage,
                userUsage,
                totalUsage,
                percentCPU)
    }
}
