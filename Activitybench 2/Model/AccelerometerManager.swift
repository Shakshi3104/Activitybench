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
    private var predictionTimes = [Double]()
    private var batteryLevels = [Float]()
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
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
            
            let batteryLevel = UIDevice.current.batteryLevel
            batteryLevels.append(batteryLevel)
            
            print("\(output.classLabel) (\(output.Identity[output.classLabel] ?? 0)")
            
            // init predictionData
            predictionData = [Double]()
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
    func stopUpdate() {
        self.timer.invalidate()
        
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
        
        predictionData = [Double]()
        
        predictionTimes = [Double]()
        batteryLevels = [Float]()
    }
}
