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
    private let defaultCollectionName = BenchmarkManager.DEFAULT_COLLECTION_NAME
    @State private var urlItem: URLItem?
    
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
                        .onTapGesture {
                            if let url = URL(string: "https://github.com/Shakshi3104/Activitybench") {
                                urlItem = URLItem(url: url)
                            }
                        }
                    
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
        .sheet(item: $urlItem) {
            // Handle the dismissing action
            print("dismiss")
            urlItem = nil
        } content: { item in
            SafariView(url: item.url)
        }

    }
}

// MARK: - URLItem
struct URLItem: Identifiable {
    var id = UUID()
    let url: URL
}

// MARK: - Package list
struct PackageList: View {
    @State private var urlItem: URLItem?
    
    var body: some View {
        List {
            Text("Firebase")
                .onTapGesture {
                    if let url = URL(string: "https://github.com/firebase/firebase-ios-sdk/blob/master/SwiftPackageManager.md") {
                        urlItem = URLItem(url: url)
                    }
                }
            Text("DeviceHardware")
                .onTapGesture {
                    if let url = URL(string: "https://github.com/Shakshi3104/DeviceHardware") {
                        urlItem = URLItem(url: url)
                    }
                }
            Text("ProcessorKit")
                .onTapGesture {
                    if let url = URL(string: "https://github.com/Shakshi3104/ProcessorKit") {
                        urlItem = URLItem(url: url)
                    }
                }
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(item: $urlItem) {
            // Handle the dismissing action
            print("dismiss")
            urlItem = nil
        } content: { item in
            SafariView(url: item.url)
        }

    }
}

// MARK: - Previews
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
