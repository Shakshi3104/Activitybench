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
    @State private var collectionName = ""
    private let defaultCollectionName = "latency_v2"
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("App")) {
                    ListRow(key: "App icon", value: "Default")
                }
                
                Section(header: Text("Firebase")) {
                    HStack {
                        Text("Collection name")
                        Spacer()
                        TextField(defaultCollectionName, text: $collectionName)
                            .multilineTextAlignment(.trailing)
                    }
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
                        // set collection name in UserDefaults
                        let key = "latencyCollectionName"
                        let value = collectionName.isEmpty ?  defaultCollectionName : collectionName
                        
                        UserDefaults.standard.set(value, forKey: key)
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            let value = UserDefaults.standard.string(forKey: "latencyCollectionName") ?? ""
            
            if value == defaultCollectionName {
                collectionName = ""
            } else {
                collectionName = value
            }
        }
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
