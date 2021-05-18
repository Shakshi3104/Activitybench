//
//  UtilesView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

struct ListRow: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct OptionSelectionView: View {
    var key: String
    @Binding var selection: Int
    var items: [String]
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Menu {
                Picker(selection: $selection, label: Text(key), content: {
                    ForEach(0..<items.count) { index in
                        Text(items[index])
                    }
                })
            } label: {
                Text(items[selection])
            }
        }
    }
    
}

struct DeviceInfoListSection: View {
    let deviceInfo = DeviceInfo.shared
    
    var body: some View {
        Section(header: Text("Device Info")) {
            ListRow(key: "Device", value: deviceInfo.device)
            ListRow(key: "OS", value: deviceInfo.os)
            ListRow(key: "Processor", value: deviceInfo.processor)
            ListRow(key: "CPU", value: deviceInfo.cpu)
            ListRow(key: "GPU", value: deviceInfo.gpu)
            ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
            ListRow(key: "RAM", value: deviceInfo.ramString)
        }
    }
}
