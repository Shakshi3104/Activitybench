//
//  Activitybench_2App.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI
import Firebase

@main
struct Activitybench2App: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BenchmarkManager())
        }
    }
}
