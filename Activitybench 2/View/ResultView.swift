//
//  ResultView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/18.
//

import SwiftUI

struct ResultView: View {
    let deviceInfo = DeviceInfo.shared
    var modelInfo: ModelInfo
    
    var body: some View {
        List {
            Section(header: Text("Activitybench").font(.headline)) {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ScoreView(name: "Accuracy", score: "85.4%")
                        Spacer()
                        ScoreView(name: "Inference time", score: "0.005s")
                        Spacer()
                        ScoreView(name: "Battery consumption", score: "5%")
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            Section(header: Text("Model Info")) {
                ListRow(key: "Model", value: modelInfo.modelArchitecture.rawValue)
                ListRow(key: "Weights", value: modelInfo.quantization.rawValue)
                ListRow(key: "Size", value: modelInfo.modelSize)
                ListRow(key: "Compute Units", value: modelInfo.computeUnits.rawValue)
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

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(modelInfo: ModelInfo(modelArchitecture: .vgg16, quantization: .float32, computeUnits: .all, modelSize: "18.1MB"))
    }
}
