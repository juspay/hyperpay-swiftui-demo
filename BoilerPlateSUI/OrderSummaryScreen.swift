//
//  OrderSummaryScreen.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 04/11/22.
//

import SwiftUI

struct OrderSummaryScreen: View {
    
    @EnvironmentObject var environment: Environment
    
    @Binding var itemCount: Int
    @State private var allowTaps: Bool = true
    @State private var showLoader: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Item 1")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Qty. \(itemCount)")
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text("₹ \(itemCount * 1)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.trailing)
                    }
                    
                    VStack {
                        Color.gray
                    }
                    .frame(height: 1.0)
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Total")
                            .padding()
                        
                        Spacer()
                        
                        Text("₹ \(itemCount * 1)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.trailing)
                    }
                }
                .padding()
                .background(
                    Color.white.cornerRadius(10.0)
                        .shadow(radius: 5.0)
                )
                
                Spacer()
                
                Button {
                    startHyperProcess()
                } label: {
                    Text("Go to Payments")
                        .customButton()
                }
            }
            .padding()
            
            if (showLoader) {
                LoaderView()
                    .edgesIgnoringSafeArea(.all)
            }
            
        }
        .navigationTitle("Order Summary")
        .allowsHitTesting(allowTaps)
    }
    
    func startHyperProcess() {
        
        if environment.paymentsHelper.hyperInstance.isInitialised() {
            // Updating HyperSDKCallback to receive callback in this screen.
            environment.paymentsHelper.hyperInstance.hyperSDKCallback = { response in
                if let response = response, let event = response["event"] as? String {
                    print(response)
                    if event == "hide_loader" {
                        showLoader = false
                    } else if event == "process_result" {
                        allowTaps = true
                    }
                }
            }
            
            let processPayload = environment.paymentsHelper.generateProcessPayload("\(itemCount * 1)")
            
            showLoader = true
            allowTaps = false
            environment.paymentsHelper.hyperInstance.process(processPayload)
        }
    }
}

struct LoaderView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.gray)
        .opacity(0.5)
        
    }
}

struct OrderSummaryScreen_Previews: PreviewProvider {
    
    @State static var itemCount : Int = 1
    
    static var previews: some View {
        OrderSummaryScreen(itemCount: $itemCount)
    }
}
