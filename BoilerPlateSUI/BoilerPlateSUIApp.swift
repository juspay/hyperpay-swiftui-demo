//
//  BoilerPlateSUIApp.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 31/10/22.
//

import SwiftUI
import HyperSDK

class Environment: ObservableObject {
    lazy var paymentsHelper = PaymentsHelper()
}

extension Color {
    static let customPrimary = Color("customPrimary")
}

@main
struct BoilerPlateSUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(Environment())
        }
    }
}
