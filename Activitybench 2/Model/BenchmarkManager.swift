//
//  BenchmarkManager.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import Combine
import CoreML
import UIKit
import FirebaseFirestore

// MARK:- BenchmarkManager
class BenchmarkManager: ObservableObject {
    private let dataset = BenchmarkDataset()
    private let accelerometerManager = AccelerometerManager()
    
    /// - Tag: Benchmark result
    @Published var results = BenchmarkResult()
    
    /// - Tag: Model information
    @Published var modelInfo: ModelInfo!
    
    /// - Tag: Model
    private var model: UnifiedMLModel!
    
    
    func run(_ modelConfig: ModelConfiguration) {
        self.runLatency(modelConfig)
    }
    
    func finish() {
        self.finishLatency()
        
        print("Finished running benchmarks!!")
    }
    
    func cancel() {
        let _ = accelerometerManager.stopUpdate()
        // 画面の明るさを最も明るくする
        UIScreen.main.brightness = 0.5
        
        print("Canceled runnning benchmarks")
    }
}

// MARK:- BenchmarkManager latency
private extension BenchmarkManager {
    /// Benchmarking latency
    func runLatency(_ modelConfig: ModelConfiguration) {
        // 画面の明るさを最も暗くする
        UIScreen.main.brightness = 0.0
        
        // モデルの設定
        self.setModel(modelConfig)
        
        // 推論時間とバッテリー消費量の計測開始
        accelerometerManager.startUpdate(100.0, model: model)
    }
    
    /// Finish lanetcy benchmarking
    func finishLatency() {
        // 加速度センサの値の取得を止める
        let result = accelerometerManager.stopUpdate()
        
        // 推定精度の計算
        let accuracy = calcAccuracy(model: model)
        self.results.accuracy = accuracy
        
        // 推論時間・バッテリー消費量を保存する
        self.results.inferenceTime = result.predictionTime
        self.results.batteryConsumption = result.batteryConsumption * 100
        print("Window prediction time: \(result.predictionTime)")
        
        // 画面の明るさを最も明るくする
        UIScreen.main.brightness = 1.0
        
        // Firebaseにデータを送る
        let data = getPushingData()
        pushFirestore(data: data)
    }
}

// MARK:- BenchmarkManager battery
private extension BenchmarkManager {
    /// Benchmarking battery
    func runBattery(_ modelConfig: ModelConfiguration, isBrightnessMax: Bool) {
        if isBrightnessMax {
            UIScreen.main.brightness = 1.0
        } else {
            UIScreen.main.brightness = 0.0
        }
        
        // バックライトの情報を記録
        self.results.isBrightnessMax = isBrightnessMax
        
        // モデルの設定
        self.setModel(modelConfig)
        
        // 推論時間とバッテリー消費量の計測開始
        accelerometerManager.startUpdate(100.0, model: model)
    }
    
    /// Finish battery benchmarking
    func finishBattery() {
        // 加速度センサの値の取得を止める
        let result = accelerometerManager.stopUpdate()
        
        // 推論時間・バッテリー消費量を保存する
        self.results.inferenceTime = result.predictionTime
        self.results.batteryConsumption = result.batteryConsumption * 100
        
        // 画面の明るさを0.0->1.0->0.5にする
        UIScreen.main.brightness = 0.0
        sleep(1)
        UIScreen.main.brightness = 1.0
        sleep(1)
        UIScreen.main.brightness = 0.5
        
        // Firebaseにデータを送る
        let data = getPushingData()
        pushFirestore(data: data)
    }
}

// MARK:- BenchmarkManager utils
private extension BenchmarkManager {
    /// Set model for benchmark
    func setModel(_ modelConfig: ModelConfiguration) {
        // Compute Unitsの選択
        let config = MLModelConfiguration()
        switch modelConfig.computeUnits {
        case .cpuOnly:
            config.computeUnits = .cpuOnly
        case .cpuAndGPU:
            config.computeUnits = .cpuAndGPU
        case .all:
            config.computeUnits = .all
        }
        
        // モデルを作る
        self.model = createMLModel(modelConfig.architecture,
                                   quantization: modelConfig.quantization,
                                   configuration: config)
        // モデル情報を保持する
        self.modelInfo = ModelInfo(configuration: modelConfig, modelSize: model.size)
    }
    
    /// Calcurate test accuracy of the model
    func calcAccuracy(model: UnifiedMLModel) -> Double {
        let startTime = Date()
        // Prediction batch
        guard let outputs = try? model.predictions(inputs: dataset.data) else {
            fatalError()
        }
        let finishTime = Date()
        let batchPredictionTime = finishTime.timeIntervalSince(startTime)
        print("Batch prediction time: \(batchPredictionTime)")
        
        // String -> ActivityLabel -> Int
        let classCodes: [Int] = outputs.map { ActivityLabel(name: $0.classLabel)!.code }
        // calc accuracy
        let correctPredictionCount = zip(classCodes, dataset.target).filter { $0 == $1 }.count
        let accuracy = Double(correctPredictionCount) / Double(classCodes.count) * 100.0
        print("Accuracy = \(accuracy)%")
        return accuracy
    }
    
    /// Create MLModel
    func createMLModel(_ modelArchitecture: ModelArchitecture, quantization: Quantization, configuration: MLModelConfiguration) -> UnifiedMLModel {
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
    
    /// Generate data for pushing to Firestore
    func getPushingData() -> [String: Any] {
        var data = [String: Any]()
        
        // Model performance
        data["accuracy"] = self.results.accuracy
        data["Prediction time"] = self.results.inferenceTime
        data["Battery consumption"] = self.results.batteryConsumption
        
        // Model information
        data["Model"] = self.modelInfo.configuration.architecture.rawValue
        data["Weights"] = self.modelInfo.configuration.quantization.rawValue
        data["Size"] = self.modelInfo.modelSize
        data["Compute units"] = self.modelInfo.configuration.computeUnits.rawValue
        
        // Device information
        let deviceInfo = DeviceInfo.shared
        data["Device"] = deviceInfo.device
        data["OS"] = deviceInfo.os
        data["Processor"] = deviceInfo.processor
        data["CPU"] = deviceInfo.cpu
        data["GPU"] = deviceInfo.gpu
        data["Neural Engine"] = deviceInfo.neuralEngine
        data["RAM"] = deviceInfo.ramString
        
        data["RAM [B]"] = deviceInfo.ram
        data["Processor count"] = deviceInfo.cpuCount
        data["Model Identifier"] = deviceInfo.modelIdentifier
        
        return data
    }
    
    /// Push data to Firestore
    func pushFirestore(data: [String: Any]) {
        var data_ = data
        data_["date"] = Date()
        
        let db = Firestore.firestore()
        db.collection("activitybench").addDocument(data: data_) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Push Firestore")
        }
    }
}
