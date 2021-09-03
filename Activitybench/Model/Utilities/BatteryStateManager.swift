//
//  BatteryStateManager.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/06/01.
//

import Foundation
import UIKit

class BatteryStateManager: ObservableObject {
    @Published var batteryLevel: Float
    @Published var batteryState: UIDevice.BatteryState
    @Published var batteryCharging: Bool?
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        self.batteryLevel = UIDevice.current.batteryLevel
        self.batteryState = UIDevice.current.batteryState
        
        switch batteryState {
        case .unplugged:
            self.batteryCharging = false
        case .charging, .full:
            self.batteryCharging = true
        default:
            self.batteryCharging = nil
        }
    }
    
    func startBatteryMonitoring() {
        print("Start battery monitoring")
        
        self.batteryLevel = UIDevice.current.batteryLevel
        self.batteryState = UIDevice.current.batteryState
        
        switch batteryState {
        case .unplugged:
            self.batteryCharging = false
        case .charging, .full:
            self.batteryCharging = true
        default:
            self.batteryCharging = nil
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelChanged(notification:)),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(batteryStateChanged(notification:)),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil)
    }
    
    func stopBatteryMonitoring() {
        print("Stop battery monitoring")
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil)
        
    }
}

private extension BatteryStateManager {
    @objc func batteryLevelChanged(notification: Notification) {
        self.batteryLevel = UIDevice.current.batteryLevel
        print("Battery level is changed: \(batteryLevel)")
    }
    
    @objc func batteryStateChanged(notification: Notification) {
        self.batteryState = UIDevice.current.batteryState
        print("Battery state is changed: \(batteryState.rawValue)")
        
        switch batteryState {
        case .unplugged:
            self.batteryCharging = false
        case .charging, .full:
            self.batteryCharging = true
        default:
            self.batteryCharging = nil
        }
    }
}
