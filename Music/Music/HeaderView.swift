//
//  HeaderView.swift
//  Music
//
//  Created by QuangHo on 30/07/2022.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            HStack {
                Button {
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.all)
                        .background(Color("GrayButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.all)
                        .background(Color("GrayButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                }
            }
            Text("Now Playing")
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
