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
    
    /// - Tag: Option selections
    @State private var quantizationSelection = 0
    @State private var computeUnitsSelection = 0
    @State private var modelArchitectureSelection = 0
    @State private var benchmarkSelection = 0
    
    /// - Tag: Benchmark options
    /// - Model architecture
    /// - Weight quantization
    /// - Compute units
    /// - Benchmark type
    private let modelArchitecture = ModelArchitecture.allCases.map { $0.rawValue }
    private let quantization = Quantization.allCases.map { $0.rawValue }
    private let computeUnits = ComputeUnits.allCases.map { $0.rawValue }
    
    /// - Tag: Benchmark manager
    @EnvironmentObject var benchmarkManager: BenchmarkManager
    /// - Tag: Battery state manager
    @EnvironmentObject var batteryStateManager: BatteryStateManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device Info")) {
                    ListRow(key: "Device", value: deviceInfo.device)
                    ListRow(key: "OS", value: deviceInfo.os)
                    ListRow(key: "Processor", value: deviceInfo.processor)
                    ListRow(key: "RAM", value: deviceInfo.ramString)
                }
                
                Section(header: Text("Select Benchmark")) {
                   
                    OptionSelectionView(key: "Benchmark Type", selection: $benchmarkSelection, items: ["Latency"])
                    OptionSelectionView(key: "Model", selection: $modelArchitectureSelection, items: modelArchitecture)
                    OptionSelectionView(key: "Quantization", selection: $quantizationSelection, items: quantization)
                    OptionSelectionView(key: "Compute Units", selection: $computeUnitsSelection, items: computeUnits)
                    
                    ZStack {
                        NavigationLink(
                            destination:
                                ResultView(),
                            isActive: $isFinished,
                            label: {
                                EmptyView()
                            })
                        
                        Button(action: {
                            
                            isPresented = true
                            isFinished = false
                            
                            // Model configuration
                            let architecture = ModelArchitecture(rawValue: modelArchitecture[modelArchitectureSelection])!
                            let quantization = Quantization(rawValue: quantization[quantizationSelection])!
                            let computeUnits = ComputeUnits(rawValue: computeUnits[computeUnitsSelection])!
                            
                            let modelConfig = ModelConfiguration(
                                architecture: architecture,
                                quantization: quantization,
                                computeUnits: computeUnits
                            )
                            
                            // run benckmark
                            benchmarkManager.run(modelConfig)

                        }, label: {
                            Text("Run Inference Benchmark")
                        })
                        .fullScreenCover(isPresented: $isPresented, content: {
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
        TopView().environmentObject(BenchmarkManager())
            .environmentObject(BatteryStateManager())
    }
}
