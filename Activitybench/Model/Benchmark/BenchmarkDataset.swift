//
//  BenchmarkDataset.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import Foundation
import CoreML


private func loadData() -> [[Double]] {
    guard let fileURL: URL = Bundle.main.url(forResource: "activitybench_xtest_v3", withExtension: "csv") else {
                fatalError("Couldn't find activitybench_xtest_v3.csv")
    }

    guard let csvString = try? String(contentsOf: fileURL, encoding: String.Encoding.utf8) else {
        fatalError("Couldn't read activitybench_xtest_v3.csv")
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
    guard let fileURL = Bundle.main.url(forResource: "activitybench_ytest_v3", withExtension: ".csv") else {
        fatalError("Couldn't find activitybench_ytest_v3.csv")
    }
    
    guard let csvString = try? String(contentsOf: fileURL, encoding: String.Encoding.utf8) else {
        fatalError("Couldn't read activitybench_ytest_v3.csv")
    }
    
    // 改行コード区切り->Intに変換-> [Int]
    let outTarget = csvString.components(separatedBy: .newlines).map { Int($0) ?? -1 }
    return outTarget
}


internal struct BenchmarkDataset {
    let data: [MLMultiArray]
    let target: [Int]
    
    init() {
        data = loadDataAsMLMultiArray()
        target = loadTarget()
    }
}
