//
//  AppDelegate.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 03/11/22.
//

import UIKit
// MARK: 1. HyperSDK import statement
import HyperSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: 2. UIWindow property
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: 3. preFetch function call
        // START of preFetch
        let clientId = "geddit" // Unique resource identifier ("getsimpl" - sample one)

        // Setting clientId as nested to ensure uniformity across payloads
        var innerPayload : [String:Any] = [:]
        innerPayload["clientId"] = clientId

        // service acts as a product reference
        let payload = [
           "payload" : innerPayload,
           "service" : "in.juspay.hyperpay"
        ] as [String: Any]
              
        HyperServices.preFetch(payload)
        // END of preFetch
        
        return true
    }
    
    // MARK: 4. openUrl delegate function to handle incoming intent
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let juspayRegex = try? NSRegularExpression(pattern: "amzn-.*|juspay.*", options: [])
        if (juspayRegex?.numberOfMatches(in: url.absoluteString, options: [], range: NSRange(location: 0, length: url.absoluteString.count)) ?? 0) > 0 {
            return HyperServices.handleRedirectURL(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String ?? "")
        }
        
        return false
    }
}

