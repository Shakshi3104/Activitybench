//
//  SettingView.swift
//  Activitybench
//
//  Created by MacBook Pro M1 on 2021/09/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var isActivePackages = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("App")) {
                    ListRow(key: "App icon", value: "Default")
                }
                
                Section(header: Text("Firebase")) {
                    ListRow(key: "Collection name", value: "latency_v2")
                }
                
                Section(header: Text("Information")) {
                    ListRow(key: "Version", value: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
                    ListRow(key: "GitHub", value: "Shakshi3104/Activitybench")
                    
                    NavigationLink(
                        destination: PackageList(),
                        isActive: $isActivePackages,
                        label: {
                            Text("Package Dependencies")
                        })
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        // close sheet
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Package list
struct PackageList: View {
    var body: some View {
        List {
            Text("Firebase")
            Text("DeviceHardware")
        }
        .listStyle(InsetGroupedListStyle())
    }
}

// MARK: - Previews
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
