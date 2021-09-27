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
                    getDeviceIcon()
                    Text("Device")
                }
        }
    }
}

// MARK: - Change the device icon for each OS
func getDeviceIcon() -> Image {
    #if targetEnvironment(macCatalyst)
        // TODO: Change the device icon for each Mac series via DeviceHardware
        return Image(systemName: "laptopcomputer")
    #else
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        return Image(systemName: "iphone")
    case .pad:
        return Image(systemName: "ipad")
    default:
        return Image(systemName: "ipod")
    }
    #endif
}

// MARK:-
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
