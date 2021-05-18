//
//  TopView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

struct TopView: View {
    let deviceInfo = DeviceInfo.shared
    @State var isPresented = false
    @State var isFinished = false
    
    @State private var quantizationSelection = 0
    @State private var computeUnitsSelection = 0
    @State private var modelArchitectureSelection = 0
    
    private let modelArchitecture = ModelArchitecture.allCases.map { $0.rawValue }
    private let quantization = Quantization.allCases.map { $0.rawValue }
    private let computeUnits = ComputeUnits.allCases.map { $0.rawValue }
    
    var body: some View {
        NavigationView {
            List {
                DeviceInfoListSection()
                
                Section(header: Text("Select Benchmark")) {
                    OptionSelectionView(key: "Model", selection: $modelArchitectureSelection, items: modelArchitecture)
                    OptionSelectionView(key: "Quantization", selection: $quantizationSelection, items: quantization)
                    OptionSelectionView(key: "Compute Units", selection: $computeUnitsSelection, items: computeUnits)
                    
                    ZStack {
                        NavigationLink(
                            destination:
                                ResultView(modelInfo: ModelInfo(modelArchitecture: ModelArchitecture(rawValue: modelArchitecture[modelArchitectureSelection])!,
                                                                         quantization: Quantization(rawValue: quantization[quantizationSelection])!,
                                                                         computeUnits: ComputeUnits(rawValue: computeUnits[computeUnitsSelection])!,
                                                                         modelSize: "??")),
                            isActive: $isFinished,
                            label: {
                                EmptyView()
                            })
                        
                        Button(action: {
                            isPresented = true
                            isFinished = false
                        }, label: {
                            Text("Run Inference Benchmark")
                        })
                        .sheet(isPresented: $isPresented, content: {
                            RunView(isPresented: $isPresented, isFinished: $isFinished)
                        })
                    }
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("Activitybench")
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
