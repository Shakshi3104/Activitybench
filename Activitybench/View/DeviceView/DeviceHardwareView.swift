//
//  DeviceHardwareView.swift
//  Activitybench
//
//  Created by MacBook Pro M1 on 2021/09/20.
//

import SwiftUI

struct DeviceHardwareView: View {
    private let deviceInfo = DeviceInfo.shared
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ListRow(key: "Device", value: deviceInfo.device)
                    ListRow(key: "Model Identifier", value: deviceInfo.modelIdentifier)
                    ListRow(key: "OS", value: deviceInfo.os)
                    ListRow(key: "Processor", value: deviceInfo.processor)
                    ListRow(key: "CPU", value: deviceInfo.cpu)
                    ListRow(key: "GPU", value: deviceInfo.gpu)
                    ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                    ListRow(key: "RAM", value: deviceInfo.ramString)
                }
            }
            .listStyle(InsetGroupedListStyle())
            // Navigation Title
            .navigationTitle(DeviceInfo.shared.device)
            // Setting
            #if DEBUG
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                }
            }
            .sheet(isPresented: $isPresented) {
                // onDismiss
            } content: {
                SettingView()
            }
            #endif

        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct DeviceHardwareView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceHardwareView()
    }
}
