//
//  MLModel+Extension.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import CoreML

// MARK: - Unified MLModel
protocol UnifiedMLModel {
    var size: String { get }
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput]
}

// MARK: - Unified ModelOutput
protocol UnifiedModelOutput {
    var Identity: [String: Double] { get }
    var classLabel: String { get }
}

// MARK: - Extend MLModel


// MARK: - Extend ModelOutput
