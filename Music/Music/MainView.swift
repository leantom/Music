//
//  MainView.swift
//  Music
//
//  Created by QuangHo on 28/07/2022.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State var selectedTab = "house"
    @State var tabPoints:[CGFloat] = []
    
    var body: some View {
        VStack(alignment: .center) {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
           // CustomTabbar(selectedTab: $selectedTab)
        }.background(
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360))
        )
        
    }
    
    enum Tabs{
           case tab1, tab2
       }
       
       func returnNaviBarTitle(tabSelection: Tabs) -> String{//this function will return the correct NavigationBarTitle when different tab is selected.
           switch tabSelection{
               case .tab1: return "Tab1"
               case .tab2: return "Tab2"
           }
       }
    
}
