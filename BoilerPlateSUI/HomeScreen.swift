//
//  HomeScreen.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 04/11/22.
//

import SwiftUI
import HyperSDK

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                Color.customPrimary.cornerRadius(10.0)
            )
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}


struct HomeScreen: View {
    
    @EnvironmentObject var environemnt: Environment
    @State var itemCount: Int = 1
    @State var showCartScreen: Bool = false
    
    let viewController = UIViewController()
    
    var body: some View {
        NavigationView(content: {
            VStack() {
                HStack {
                    Image(systemName: "leaf")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.leading)
                    
                    VStack(alignment:.leading, spacing: 10) {
                        Text("Item 1")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("₹ 1.00")
                            
                    }.padding(.leading)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        
                        Button(action: {
                            if (itemCount > 1) {
                                itemCount -= 1
                            }
                        }) {
                            Text("-")
                                .frame(width: 30, height: 35)
                                .foregroundColor(.white)
                                .background(Color.customPrimary)
                                .font(.title)
                        }
                        
                        Text("\(itemCount)")
                            .frame(width: 35, height: 35)
                        
                        Button(action: {
                            itemCount += 1
                        }) {
                            Text("+")
                                .frame(width: 30, height: 35)
                                .foregroundColor(.white)
                                .background(Color.customPrimary)
                                .font(.title)
                        }
                    }
                    .cornerRadius(5.0)
                    
                }
                .padding()
                .background(
                    Color.white.cornerRadius(10.0)
                        .shadow(radius: 5.0)
                )
                
                Spacer()
                
                
                NavigationLink(destination: environemnt.paymentsHelper.viewControllerWithRootView(view: OrderSummaryScreen(itemCount: $itemCount))) {
                    Text("Go to Cart")
                        .customButton()
                }
            }
            .navigationTitle("Home Screen")
            .padding()
        })
        .accentColor(.customPrimary)
    }
}

struct HomeScreen_Previews: PreviewProvider {

    static var previews: some View {
        HomeScreen()
    }
}
