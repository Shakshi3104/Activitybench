//
//  ModelInformation.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/18.
//

import Foundation

class ModelConfiguration {
    let architecture: ModelArchitecture
    let quantization: Quantization
    let computeUnits: ComputeUnits
    
    init(architecture: ModelArchitecture, quantization: Quantization, computeUnits: ComputeUnits) {
        self.architecture = architecture
        self.quantization = quantization
        self.computeUnits = computeUnits
    }
}

struct ModelInfo {
    let configuration: ModelConfiguration
    let modelSize: String
}
