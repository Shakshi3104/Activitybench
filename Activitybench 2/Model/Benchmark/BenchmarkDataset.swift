//
//  BenchmarkDataset.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import CoreML

internal struct BenchmarkDataset {
    var data: [MLMultiArray] { return loadDataAsMLMultiArray() }
    var target: [Int] { return loadTarget() }
    
    private func loadData() -> [[Double]] {
        guard let fileURL: URL = Bundle.main.url(forResource: "activitybench_xtest", withExtension: "csv") else {
                    fatalError("Couldn't find activitybench_xtest.csv")
        }

        guard let csvString = try? String(contentsOf: fileURL, encoding: String.Encoding.utf8) else {
            fatalError("Couldn't read activitybench_xtest.csv")
        }

        // 改行コード区切り->カンマ区切り->Doubleに変換-> [[Double]]
        let outData = csvString.components(separatedBy: .newlines).map { $0.components(separatedBy: ",").map { Double($0) ?? Double.nan } }

        return outData
    }
    
    private func loadDataAsMLMultiArray() -> [MLMultiArray] {
        let dataDouble = loadData()
        let dataMLMultiArray = dataDouble.map { try! MLMultiArray.fromDouble($0) }
        return dataMLMultiArray
    }
    
    private func loadTarget() -> [Int] {
        guard let fileURL = Bundle.main.url(forResource: "activitybench_ytest", withExtension: ".csv") else {
            fatalError("Couldn't find activitybench_ytest.csv")
        }
        
        guard let csvString = try? String(contentsOf: fileURL, encoding: String.Encoding.utf8) else {
            fatalError("Couldn't read activitybench_ytest.csv")
        }
        
        // 改行コード区切り->Intに変換-> [Int]
        let outTarget = csvString.components(separatedBy: .newlines).map { Int($0) ?? -1 }
        return outTarget
    }
}
