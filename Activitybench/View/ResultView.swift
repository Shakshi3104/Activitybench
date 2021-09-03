//
//  ResultView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/18.
//

import SwiftUI

struct ResultView: View {
    private let deviceInfo = DeviceInfo.shared
    
    var benchmarkType: BenchmarkType
    
    @EnvironmentObject var benchmarkManager: BenchmarkManager
        
    var body: some View {
        List {
            Section(header: Text("Activitybench").font(.headline)) {
                HStack {
                    Spacer()
                    VStack {
                        switch benchmarkType {
                        case .latency:
                            Spacer()
                            ScoreView(name: "Accuracy", score: "\(String(format: "%.2f", benchmarkManager.results.accuracy))%")
                            Spacer()
                            ScoreView(name: "Inference time", score: "\(String(format: "%.5f", benchmarkManager.results.inferenceTime))s")
                            Spacer()
                        case .battery:
                            Spacer()
                            ScoreView(name: "Battery Consumption time", score: "\(formatTimeInterval(time: benchmarkManager.results.batteryConsumptionTime))")
                            Spacer()
                            ScoreView(name: "Brightness", score: "\(benchmarkManager.results.isBrightnessMax ? "High" : "Low")")
                            Spacer()
                        }
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
    
    private func formatTimeInterval(time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        
        return formatter.string(from: time) ?? "???"
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
