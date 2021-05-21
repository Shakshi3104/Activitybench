//
//  ResultView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/18.
//

import SwiftUI

struct ResultView: View {
    let deviceInfo = DeviceInfo.shared
    
    @EnvironmentObject var benchmarkManager: BenchmarkManager
        
    var body: some View {
        List {
            Section(header: Text("Activitybench").font(.headline)) {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ScoreView(name: "Accuracy", score: "\(String(format: "%.2f", benchmarkManager.results.accuracy))%")
                        Spacer()
                        ScoreView(name: "Inference time", score: "\(String(format: "%.5f", benchmarkManager.results.inferenceTime))s")
                        Spacer()
                        ScoreView(name: "Battery consumption", score: "\(Int(benchmarkManager.results.batteryConsumption))%")
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            Section(header: Text("Model Info")) {
                ListRow(key: "Model", value: benchmarkManager.modelInfo.configuration.architecture.rawValue)
                ListRow(key: "Weights", value: benchmarkManager.modelInfo.configuration.quantization.rawValue)
                ListRow(key: "Size", value: benchmarkManager.modelInfo.modelSize)
                ListRow(key: "Compute Units", value: benchmarkManager.modelInfo.configuration.computeUnits.rawValue)
            }
            
            DeviceInfoListSection()
        }.listStyle(InsetGroupedListStyle())
    }
}

struct ScoreView: View {
    var name: String
    var score: String
    
    var body: some View {
        VStack {
            Text(score)
                .font(.title3)
            Text(name)
                .font(.caption)
        }
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//            .environmentObject(BenchmarkManager())
//    }
//}
