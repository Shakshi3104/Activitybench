//
//  BenchmarkManager.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import Combine
import CoreML

class BenchmarkManager: ObservableObject {
    private let dataset = BenchmarkDataset()
    private let accelerometerManager = AccelerometerManager()
    
    @Published var currentProgress = 0.0
    
    /// - Tag: Benchmark result
    @Published var results = BenchmarkResult()
    
    /// - Tag: Model size
    @Published var modelSize = ""
    
    func run(_ modelArchitecture: ModelArchitecture, quantization: Quantization, computeUnits: ComputeUnits) {
        
        // Compute Unitsの選択
        let config = MLModelConfiguration()
        switch computeUnits {
        case .cpuOnly:
            config.computeUnits = .cpuOnly
        case .cpuAndGPU:
            config.computeUnits = .cpuAndGPU
        case .all:
            config.computeUnits = .all
        }
        
        // モデルを作る
        let model: UnifiedMLModel = createMLModel(modelArchitecture, quantization: quantization, configuration: config)
        
        self.modelSize = model.size
        
        // 推定精度の計算
        let accuracy = calcAccuracy(model: model)
        currentProgress += 1.0
        self.results.accuracy = accuracy
        
        // 推論時間とバッテリー消費量の計測開始
        accelerometerManager.startUpdate(100.0, model: model)
    }
    
    func finish() {
        // 加速度センサの値の取得を止める
        let result = accelerometerManager.stopUpdate()
        
        // 推論時間・バッテリー消費量を保存する
        self.results.inferenceTime = result.predictionTime
        self.results.batteryConsumption = result.batteryConsumption
    }
    
    func cancel() {
        let _ = accelerometerManager.stopUpdate()
    }
    
    private func calcAccuracy(model: UnifiedMLModel) -> Double {
        guard let outputs = try? model.predictions(inputs: dataset.data) else {
            fatalError()
        }
        
        // String -> ActivityLabel -> Int
        let classCodes: [Int] = outputs.map { ActivityLabel(name: $0.classLabel)!.code }
        // calc accuracy
        let correctPredictionCount = zip(classCodes, dataset.target).filter { $0 == $1 }.count
        let accuracy = Double(correctPredictionCount) / Double(classCodes.count) * 100.0
        print("Accuracy = \(accuracy)%")
        return accuracy
    }
    
    private func createMLModel(_ modelArchitecture: ModelArchitecture, quantization: Quantization, configuration: MLModelConfiguration) -> UnifiedMLModel {
        switch modelArchitecture {
        case .vgg16:
            switch quantization {
            case .float32:
                do {
                    return try VGG16(configuration: configuration)
                } catch {
                    fatalError("Couldn't create VGG16")
                }
            case .int8:
                do {
                    return try VGG16Int8(configuration: configuration)
                } catch {
                    fatalError("Couldn't create VGG16Int8")
                }
            }
        case .resNet18:
            switch quantization {
            case .float32:
                do {
                    return try ResNet18(configuration: configuration)
                } catch {
                    fatalError("Couldn't create ResNet18")
                }
            case .int8:
                do {
                    return try ResNet18Int8(configuration: configuration)
                } catch {
                    fatalError("Couldn't create ResNet18Int8")
                }
            }
        case .mobileNet:
            switch quantization {
            case .float32:
                do {
                    return try MobileNet(configuration: configuration)
                } catch {
                    fatalError("Couldn't create MobileNet")
                }
            case .int8:
                do {
                    return try MobileNetInt8(configuration: configuration)
                } catch {
                    fatalError("Couldn't create MobileNetInt8")
                }
            }
        case .pyramidNet18:
            switch quantization {
            case .float32:
                do {
                    return try PyramidNet18(configuration: configuration)
                } catch {
                    fatalError("Couldn't create PyramidNet18")
                }
            case .int8:
                do {
                    return try PyramidNet18Int8(configuration: configuration)
                } catch {
                    fatalError("Couldn't create PyramidNetInt8")
                }
            }
        case .efficientNetB0:
            switch quantization {
            case .float32:
                do {
                    return try EfficientNetB0(configuration: configuration)
                } catch {
                    fatalError("Couldn't create EfficientNetB0")
                }
            case .int8:
                do {
                    return try EfficientNetB0Int8(configuration: configuration)
                } catch {
                    fatalError("Couldn't create EfficientNetB0Int8")
                }
            }
        }
    }
}
