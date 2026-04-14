//
//  TopHomeView.swift
//  Music
//
//  Created by QuangHo on 29/07/2022.
//

import SwiftUI

struct TopHomeView: View {
    
    var doSearch : () -> Void = {}
    
    
    func doSearchTouch(action: @escaping () -> Void) -> Self {
        var newOne = self
        newOne.doSearch = action
        return newOne
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image("background")
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack {
                Text("Good Morning")
                    .font(.caption)
                Text("Andrea Bou")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            Spacer()
            
            HStack() {
                Button {
                  doSearch()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .frame(height: 30)
                        .foregroundColor(.black)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "bell")
                        .frame(height: 30)
                        .foregroundColor(.black)
                }
            }
        }
        .frame(height: 30)
        .padding()
    }
}
