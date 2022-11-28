//
//  PaymentsHelper.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 04/11/22.
//

import UIKit
import SwiftUI
import HyperSDK

class PaymentsHelper: NSObject {
    
    let merchantId = "picasso"
    let clientId = "geddit"
    let environment = "prod"
    let returnUrl = "https://dummy.merchant.com/end"
    
    let customerId = "7338513562"
    let firstName = "Test"
    let lastName = "Customer"
    let customerEmail = "test_customer@gmail.com"
    let customerMobileNumber = "7338513562"
    
    let merchantKeyId = "9858"
    let privateKeyString = "MIIEpQIBAAKCAQEA2R+5+b1HZSNNMotnr7Z/5By4NSTZW4dDMGDy2huOSLn1EF6v\n75sssdY5kRkFoihLIeNQA+yzsi0kzpz3rCCCmo1DJwgoqA48JVQwwBjZ9SHeC0nE\n66VODmMJJGNWe1quHWQb3otIzS+U+rtd1Alzo9up8u8e+FrecyjO6fBMZfd32iO7\nqPtExtA1XDtKMqoRbHMiAz940xA5+BLmJC+gp1IYsVce2KA5BW1laPxbku42aQR7\neZipSa3BYRY8m964Aj6vLj4kTeTbrc4OH7yatRdWbVbrwVWpg936g8Q3Qf3jQY+H\nMu76l1WeXK4GkPkA+oJXY6ag1XhhqtOrLw3rJwIDAQABAoIBAQCjy2thG4lgouD5\n4HC3/dU9IO1WKhZPFht5w6lxIJiWBLL7RnMzLrzo69NBwr6dNgh36CPU0hw9rhC2\nTXQKRfxA25BtQZpqLVLyVjDwuc6zPnljyqLjojDgaZXb/ZSgOihfw8XCfRDOubaJ\n8A84hmjWlEABJKMYeHSYK5Dsqnr37/Oj4OT2NWLaRx8Kk0HPuv/bxx3MHurIHRtG\n514UJZcOfN8Ti69/DoYbtb/Mpg/djXr5s47TafxPa8jyT2E8nWboPvYPDQcdu2CI\nE0mbrj2C0Ak7g20ZYzm9HCbJHVG+2rPSjVgXKW2ZgXoZflte+G5vRfDrZH+TZuo+\nja0pVlIBAoGBAP4ZEtdpRJp5kvj7bUIkXd5E6lrxd2M0VprfMhHk0i+Z1p1nF8St\nF6p9uIGuRIEthvdRZVy56fWCHXOfmquRJDHazQZVnnXcRaqhuMYdZoJ3i1KkmSL4\nX/SdBsB4rY4FQZWNtwKoSeDugQeJzf4bhyn0iZGbWPq+XO70MxXya8CfAoGBANq/\nzL6ul+G6i/nXrfzwUr83EtXh6Zoj51YBK4g3ZIIuWkWvbo9NguV3p9KmeRKMWwYO\nRHC7aVwpHdjzOyzmSFdmC+5dqVe6rkdl9AzxpKt0p0rOznmZUhDcdElCk0p6pC5R\nQDAt2PA4aR3kT+9z2dPV0IHsUGiouF/LtmTmdCB5AoGAIShUdRefhCjpLORiVYc5\nWI/VpRhtY9yokH0fo4Ygh2Wjw9Z4G4oa1HyjXwjGl7TBL/THLVp1VTwta7EgFdNS\nzc6ngnQZwXeE/8cqvW+IuO2wmJAyC4Ytv1XeU69rtmSpMkLT5tzfByMYY0twPgCJ\nmsf2S7Hh4paEugnTwMFpnjECgYEAoTqc/i5RY97LLOr7ImM/mhBNobdRJnswFwPl\nwhCR1CG2B4a2Rokq4VbAK1LoCfPJYz1A1JZNoc/sX+tmwkE5MLHWOWpvVmoR6i4L\nIz83z+e7JjgnlxialDLowtZ/GXYrbLgWR2yDaQsq7w1InYUWGDyP4jL7USiKPJE5\nbkUtcoECgYEAwhbb1NxzteIr8zlytMj52sgeiJPQRjbU5CoMAJuiHvYHT8jQwso7\nlfbz+fXdQamU29v1Hdhc2JR1xWxrTz4bAt1l9lWK8zQBTK3SOlhyvrvNkKtTwjan\nsR6+uwB9KY5mrF++pRA8IL2f0yhx2uqwDkX/Og6ZnFHJn3BvQM/DWPg="
    
    let action = "paymentPage"
    var orderId: String!
    
    lazy var hyperInstance = HyperServices()

    // MARK: Helper functions
    func initiateHyper(payload: [String: Any]) {
        // Passing a dummy ViewController object. Later it can be updated with the actual base view controller.
        hyperInstance.initiate(UIViewController(), payload: payload) { [unowned self] response in
            if let response = response, let event = response["event"] as? String {
                if event == "initiate_result" {
                    // Check if you are getting success status in the response.
                    // If not please check errorMessage for the reason.
                    print(response)
                }
            }
        }
    }
    
    // Generic function to create a UIHostingController with a rootView and set it as the baseViewController of HyperSDK.
    // baseViewController is the screen on which HyperSDK will render its UI.
    struct HyperViewController<T: View>: UIViewControllerRepresentable {
        
        var rootView : T
        var hyperInstance : HyperServices
        
        func makeUIViewController(context: Context) -> UIHostingController<T> {
            
            let hostingVC = UIHostingController(rootView: rootView)
            hyperInstance.baseViewController = hostingVC
            return hostingVC
        }
        
        func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {
            
        }
    }
    
    // To embed a Screen view into a ViewController to use with HyperSDK
    func viewControllerWithRootView<T: View>(view: T) -> some View {
        // To initiate HyperSDK in case it's not initialised/deallocated.
        // This step is mandatory since the webview might get deallocated if the app is in the background for a long time.
        if (!hyperInstance.isInitialised()) {
            hyperInstance.terminate()
            initiateHyper(payload: generateInitiatePayload())
        }
        return HyperViewController<T>(rootView: view, hyperInstance: hyperInstance).ignoresSafeArea()
    }
    
    
    //MARK: Sample payloads
    func generateInitiatePayload() -> [String: Any] {
        
        var initiatePayload = [String : Any]()
        initiatePayload["action"] = "initiate"
        initiatePayload["clientId"] = clientId
        initiatePayload["merchantKeyId"] = merchantKeyId
        initiatePayload["environment"] = environment
        
        let signaturePayload = generateSignaturePayload().toString()
        initiatePayload["signaturePayload"] = signaturePayload
        initiatePayload["signature"] = generateSignature(signaturePayload, privateKeyString)

        return wrapWithHyperpayService(initiatePayload)
    }
    
    func generateProcessPayload(_ amount: String) -> [String: Any] {
        
        var processPayload = [String: Any]()
        processPayload["action"] = action
        processPayload["clientId"] = clientId
        processPayload["merchantKeyId"] = merchantKeyId
        processPayload["environment"] = environment
        
        orderId = generateOrderId()
        let orderDetails = generateOrderDetails(amount: amount).toString()
        processPayload["orderDetails"] = orderDetails
        processPayload["signature"] = generateSignature(orderDetails, privateKeyString)
        
        return wrapWithHyperpayService(processPayload)
    }
    
    func generateSignaturePayload() -> Dictionary<String,Any> {
        
        var signaturePayload = [String : Any]()
        signaturePayload["first_name"] = firstName
        signaturePayload["last_name"] = lastName
        signaturePayload["mobile_number"] = customerMobileNumber
        signaturePayload["email_address"] = customerEmail
        signaturePayload["customer_id"] = customerId
        signaturePayload["timestamp"] = getTimeStamp()
        signaturePayload["merchant_id"] = merchantId
        
        return signaturePayload
    }
    
    func generateOrderDetails(amount : String) -> Dictionary<String,Any> {
        
        var orderDetails = [String : Any]()
        orderDetails["order_id"] = orderId
        orderDetails["customer_id"] = customerId
        orderDetails["timestamp"] = getTimeStamp()
        orderDetails["merchant_id"] = merchantId
        orderDetails["amount"] = amount
        orderDetails["return_url"] = returnUrl
        orderDetails["description"] = "Adding to Wallet"
        
        return orderDetails
    }
    
    
    func generateSignature(_ payload: String, _ keyString: String) -> String {
        
        let encodedData =  Data(base64Encoded: keyString, options: .ignoreUnknownCharacters)!
        let privateKey:SecKey =
                SecKeyCreateWithData(encodedData as NSData, [kSecAttrKeyType: kSecAttrKeyTypeRSA,kSecAttrKeyClass: kSecAttrKeyClassPrivate] as NSDictionary, nil)!
        let data = payload.data(using: .utf8)!
        var error:Unmanaged<CFError>?
        guard let sign = SecKeyCreateSignature(privateKey,.rsaSignatureMessagePKCS1v15SHA256 ,data as CFData, &error) as Data? else {return ""}
        return sign.base64EncodedString()
    }
    
    func getTimeStamp() -> String {
        return  String (Int (round((NSDate().timeIntervalSince1970*1000))))
    }
    
    func generateRequestId() -> String {
        var uuids = UUID().uuidString.components(separatedBy: "-")
        var i = 0
        while (i < uuids.count){
            if ( i % 2 != 0){
                uuids[i] = uuids[i].uppercased()
            }
            i += 1
        }
        return uuids.joined(separator: "-")
    }
    
    func generateOrderId() -> String{
        return "R" + String(Int64.random(in: 1000000000..<9999999999))
    }
    
    func wrapWithHyperpayService(_ payload: [String: Any]) -> [String: Any] {
        return [
            "service": "in.juspay.hyperpay",
            "requestId": generateRequestId(),
            "payload": payload
        ]
    }
}

extension Dictionary {
    func toString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        }
        catch{
            return ""
        }
    }
}

