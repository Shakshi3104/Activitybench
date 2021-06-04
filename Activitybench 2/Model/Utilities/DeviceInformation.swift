//
//  DeviceInformation.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import UIKit
import DeviceHardware

class DeviceInfo {
    public static let shared = DeviceInfo()
    
    /// - Tag: system information
    let device: String
    let os: String
    let processor: String
    let cpu: String
    let gpu: String
    let neuralEngine: String
    
    let cpuCount: Int
    let ram: Int
    let ramString: String
    
    let modelIdentifier: String
    
    init() {
        // macOS or Catalystの場合
        #if os(macOS) || targetEnvironment(macCatalyst)
        device = MacDeviceHardware.deviceHardware.modelName
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        // patchVersion == 0のときは、patchVersionを表示しない
        os = "macOS \(osVersion.majorVersion).\(osVersion.minorVersion)" + (osVersion.patchVersion == 0 ? "" :  ".\(osVersion.patchVersion)")
        processor = MacDeviceHardware.deviceHardware.processorName
        cpu = MacDeviceHardware.deviceHardware.cpu
        gpu = MacDeviceHardware.deviceHardware.gpu
        neuralEngine = MacDeviceHardware.deviceHardware.neuralEngine

        cpuCount = MacDeviceHardware.deviceHardware.processorCount
        ram = MacDeviceHardware.deviceHardware.ram
        ramString = MacDeviceHardware.deviceHardware.ramString
        modelIdentifier = MacDeviceHardware.deviceHardware.modelIdentifier
        // iOSの場合
        #elseif os(iOS)
        device = UIDeviceHardware.deviceHardware.modelName
        os = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        processor = UIDeviceHardware.deviceHardware.processorName
        cpu = UIDeviceHardware.deviceHardware.cpu
        gpu = UIDeviceHardware.deviceHardware.gpu
        neuralEngine = UIDeviceHardware.deviceHardware.neuralEngine
        
        cpuCount = UIDeviceHardware.deviceHardware.processorCount
        ram = UIDeviceHardware.deviceHardware.ram
        ramString = UIDeviceHardware.deviceHardware.ramString
        modelIdentifier = UIDeviceHardware.deviceHardware.modelIdentifier
        #endif
    }
    
    
}
