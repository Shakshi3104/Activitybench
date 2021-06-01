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
    @State var isNotBatteryMax = false
    
    /// - Tag: Option selections
    @State private var quantizationSelection = 0
    @State private var computeUnitsSelection = 0
    @State private var modelArchitectureSelection = 0
    @State private var benchmarkSelection = 0
    @State private var brightnessSelection = 0
    
    /// - Tag: Benchmark options
    /// - Model architecture
    /// - Weight quantization
    /// - Compute units
    /// - Benchmark type
    private let modelArchitecture = ModelArchitecture.allCases.map { $0.rawValue }
    private let quantization = Quantization.allCases.map { $0.rawValue }
    private let computeUnits = ComputeUnits.allCases.map { $0.rawValue }
    private let benckmarkTypes = BenchmarkType.allCases.map { $0.rawValue }
    
    /// - Tag: Benchmark manager
    @EnvironmentObject var benchmarkManager: BenchmarkManager
    
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
                    OptionSelectionView(key: "Benchmark Type", selection: $benchmarkSelection, items: benckmarkTypes)
                    OptionSelectionView(key: "Model", selection: $modelArchitectureSelection, items: modelArchitecture)
                    OptionSelectionView(key: "Quantization", selection: $quantizationSelection, items: quantization)
                    OptionSelectionView(key: "Compute Units", selection: $computeUnitsSelection, items: computeUnits)
                    
                    if benchmarkSelection == 1 {
                        OptionSelectionView(key: "Display Brightness", selection: $brightnessSelection, items: ["Min", "Max"])
                    }
                    
                    ZStack {
                        // benchmark type
                        let benchmarkType = BenchmarkType(rawValue: benckmarkTypes[benchmarkSelection])!
                        
                        NavigationLink(
                            destination:
                                ResultView(benchmarkType: benchmarkType),
                            isActive: $isFinished,
                            label: {
                                EmptyView()
                            })
                        
                        Button(action: {
                            if benchmarkType == .battery {
                                if benchmarkManager.batteryStateManager.batteryLevel != 1.0 {
                                    isNotBatteryMax = true
                                    return
                                }
                            }
                            
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
                            
                            benchmarkManager.run(
                                modelConfig,
                                benchmarkType: benchmarkType,
                                isBrightnessMax: brightnessSelection == 0 ? false : true
                            )

                        }, label: {
                            Text("Run Inference Benchmark")
                        })
                        .alert(isPresented: $isNotBatteryMax, content: {
                            Alert(title: Text("Warning"),
                                  message: Text("Battery level is not 100%. Please charging."))
                        })
                        .sheet(isPresented: $isPresented, content: {
                            switch benchmarkType {
                            case .latency:
                                RunLatencyView(isPresented: $isPresented, isFinished: $isFinished)
                            case .battery:
                                RunBatteryView(isPresented: $isPresented, isFinished: $isFinished)
                            }
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
    }
}
