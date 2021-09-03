//
//  Activitybench_2App.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI
import Firebase

@main
struct ActivitybenchApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var batteryStateManager = BatteryStateManager()
    @StateObject private var benchmarkManager = BenchmarkManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(benchmarkManager)
                .environmentObject(batteryStateManager)
        }
        .onChange(of: scenePhase) { scene in
            switch scene {
            case .active:
                print("scenePhase: active")
                batteryStateManager.startBatteryMonitoring()
            case .inactive:
                print("scenePhase: inactive")
                batteryStateManager.stopBatteryMonitoring()
            case .background:
                print("scenePhase: background")
                batteryStateManager.stopBatteryMonitoring()
            @unknown default: break
            }
        }
    }
}
