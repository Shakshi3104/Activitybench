//
//  RunView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

struct RunView: View {
    @Binding var isPresented: Bool
    
    @State private var currentProgress = 0.0
    private let total = 100.0
    
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.secondary)
            
            Text("Running Benchmarks...")
            
            HStack {
                Spacer()
                let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                
                ProgressView("", value: currentProgress, total: total)
                    .onReceive(timer, perform: { _ in
                        if currentProgress < total {
                            currentProgress += 2.0
                            if currentProgress > total {
                                currentProgress = total
                            }
                        }
                        else {
                            isPresented = false
                        }
                    })
                Spacer()
            }
            
            Button(action: {
                isPresented = false
            }, label: {
                Text("Cancel")
            })
        }
    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView(isPresented: .constant(true))
    }
}
