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
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device Info")) {
                    ListRow(key: "Device", value: deviceInfo.device)
                    ListRow(key: "OS", value: deviceInfo.os)
                    ListRow(key: "Processor", value: deviceInfo.processor)
                    ListRow(key: "CPU", value: deviceInfo.cpu)
                    ListRow(key: "GPU", value: deviceInfo.gpu)
                    ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                    ListRow(key: "RAM", value: deviceInfo.ramString)
                }
                
                Section(header: Text("Select Benchmark")) {
                    ListRow(key: "Model", value: "VGG16")
                    ListRow(key: "Quantization", value: "Float 32")
                    ListRow(key: "Compute Unit", value: "All")
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Text("Run Inference Benchmark")
                    })
                    .sheet(isPresented: $isPresented, content: {
                        RunView(isPresented: $isPresented)
                    })
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
