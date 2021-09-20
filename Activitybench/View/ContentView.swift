//
//  ContentView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Activitybench
            TopView()
                .tabItem {
                    Image(systemName: "speedometer")
                    Text("Benchmark")
                }
            
            // DeviceHardware
            DeviceHardwareView()
                .tabItem {
                    Image(systemName: "iphone")
                    Text("Device")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
