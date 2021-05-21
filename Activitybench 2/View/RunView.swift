//
//  RunView.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import SwiftUI

struct RunView: View {
    @Binding var isPresented: Bool
    @Binding var isFinished: Bool
    
    @State private var currentProgress = 0.0
    private let total = 60.0 // * 60.0
    
    @EnvironmentObject var benchmarkManager: BenchmarkManager
    
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
                let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                
                ProgressView("", value: currentProgress, total: total)
                    .onReceive(timer, perform: { _ in
                        if currentProgress < total {
                            currentProgress += 1.0
                            if currentProgress > total {
                                currentProgress = total
                            }
                        }
                        else {
                            benchmarkManager.finish()
                            
                            isPresented = false
                            isFinished = true
                        }
                    })
                Spacer()
            }
            
            Button(action: {
                isPresented = false
                
                benchmarkManager.cancel()
            }, label: {
                Text("Cancel")
            })
        }
    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView(isPresented: .constant(true),
                isFinished: .constant(false))
            .environmentObject(BenchmarkManager())
    }
}
