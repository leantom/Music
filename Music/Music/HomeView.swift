//
//  HomeView.swift
//  Music
//
//  Created by QuangHo on 31/07/2022.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = "house"
    @State var tabPoints:[CGFloat] = []
    
    var body: some View {
        ZStack(alignment:.bottom) {
            Color(.gray)
                .ignoresSafeArea()
            CustomTabbar(selectedTab: $selectedTab, tabPoints: tabPoints)
        }
        
    }
}


