//
//  ActivityClassifierUtiles.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation

// MARK: - Benchmark options

enum ModelArchitecture: String, CaseIterable {
    case vgg16 = "VGG16"
    case resNet18 = "ResNet 18"
    case pyramidNet18 = "PyramidNet 18"
    case mobileNet = "MobileNet"
    case mobileNetV2 = "MobileNetV2"
    case mobileNetV3Small = "MobileNetV3Small"
    case mnasNet = "MnasNet"
    case nasNetMobile = "Mobile NASNet"
    case denseNet121 = "DenseNet 121"
    case efficientNetB0 = "EfficientNet B0"
}

enum Quantization: String, CaseIterable {
    case float32 = "Float 32"
    case int8 = "Int 8"
}

enum ComputeUnits: String, CaseIterable {
    case all = "All"
    case cpuOnly = "CPU Only"
    case cpuAndGPU = "CPU and GPU"
}

// MARK: - Activity Label

internal enum ActivityCode: Int {
    case stay = 0
    case walk = 1
    case jog = 2
    case skip = 3
    case stairUp = 4
    case stairDown = 5
}

internal enum ActivityName: String {
    case stay = "stay"
    case walk = "walk"
    case jog = "jog"
    case skip = "skip"
    case stairUp = "stUp"
    case stairDown = "stDown"
}

/// HASCの行動ラベル
public enum ActivityLabel: CaseIterable {
    case stay
    case walk
    case jog
    case skip
    case stairUp
    case stairDown
}

extension ActivityLabel {
    // 行動の番号で初期化
    public init?(code: Int) {
        self.init(ActivityCode(rawValue: code))
    }
    
    // 行動の名前で初期化
    public init?(name: String) {
        self.init(ActivityName(rawValue: name))
    }
    
    public var code: Int {
        return converted(ActivityCode.self).rawValue
    }
    
    public var name: String {
        return converted(ActivityName.self).rawValue
    }
    
    private init?<T>(_ t: T?) {
        guard let t = t else { return nil }
        self = unsafeBitCast(t, to: ActivityLabel.self)
    }
    
    private func converted<T>(_ t: T.Type) -> T {
        return unsafeBitCast(self, to: t)
    }
}

