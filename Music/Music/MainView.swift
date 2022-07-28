//
//  MainView.swift
//  Music
//
//  Created by QuangHo on 28/07/2022.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "square.and.pencil")
                }
        }
    }
}
