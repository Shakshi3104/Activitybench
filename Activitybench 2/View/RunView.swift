//
//  RunView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

// MARK:- RunLatencyView
struct RunLatencyView: View {
    @Binding var isPresented: Bool
    @Binding var isFinished: Bool
    
    @State private var currentProgress = 0.0
    private let total = 60.0
    
    @EnvironmentObject var benchmarkManager: BenchmarkManager
    
    var body: some View {
        VStack {
            Image(systemName: "clock.arrow.2.circlepath")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.secondary)
            
            Text("Running Benchmarks...")
            
            HStack {
                Spacer()
                let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                
                ProgressView("", value: currentProgress, total: total)
                    .onReceive(timer, perform: { _ in
                        if currentProgress < total {
                            currentProgress += 1.0
                            if currentProgress > total {
                                currentProgress = total
                            }
                        }
                        
                        if currentProgress >= total {
                            benchmarkManager.finish(benckmarkType: .latency)
                            
                            isPresented = false
                            isFinished = true
                        }
                    })
                Spacer()
            }
            
            Button(action: {
                isPresented = false
                
                benchmarkManager.cancel()
            }, label: {
                Text("Cancel")
            })
        }
    }
}

// MARK:- RunBatteryView
struct RunBatteryView: View {
    @Binding var isPresented: Bool
    @Binding var isFinished: Bool
    
    @State private var currentProgress = 0.0
    // バッテリーが100%から90%になるまで (10%減少するまで)
    private let total = 1.0 - 0.95
    
    @EnvironmentObject var benchmarkManager: BenchmarkManager
    @EnvironmentObject var batteryStateManager: BatteryStateManager
    
    var body: some View {
        VStack {
            Image(systemName: "battery.100")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.secondary)
            
            Text("Running Benchmarks...")
            
            HStack {
                Spacer()
                let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                
                ProgressView("", value: currentProgress, total: total)
                    .onReceive(timer, perform: { _ in
                        if currentProgress < total {
                            currentProgress = Double(1.0 - batteryStateManager.batteryLevel)
                            
                            if currentProgress > total {
                                currentProgress = total
                            }
                        }
                        
                        if currentProgress >= total {
                            benchmarkManager.finish(benckmarkType: .battery)
                            
                            isPresented = false
                            isFinished = true
                        }
                    })
                Spacer()
            }
            
            Button(action: {
                isPresented = false
                
                benchmarkManager.cancel()
            }, label: {
                Text("Cancel")
            })
        }
    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RunLatencyView(isPresented: .constant(true),
                    isFinished: .constant(false))
                .environmentObject(BenchmarkManager())
            RunBatteryView(isPresented: .constant(true),
                           isFinished: .constant(false))
                .environmentObject(BenchmarkManager())
                .environmentObject(BatteryStateManager())
        }
    }
}
