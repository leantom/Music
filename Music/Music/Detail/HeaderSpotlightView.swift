//
//  HeaderSpotlightView.swift
//  Music
//
//  Created by QuangHo on 31/07/2022.
//

import SwiftUI

struct HeaderSpotlightView: View {
    @State var titles = ["Top","Songs","Artists","Albums","Rock", "Relax"]
    let columns = [
        GridItem(.fixed(100))
    ]
    @State var istap = false
    @State var itemS = ""
    var body: some View {
        
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHGrid(rows: columns, spacing: 20) {
                ForEach(titles, id: \.self) { item in
                    Text(item)
                        .frame(width:100, height:35)
                        .font(.callout)
                        .foregroundColor(itemS == item ? .white : .black)
                        .background(itemS == item ? .green : .clear)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.green, lineWidth: 2)
                        )
                        .onTapGesture {
                            itemS = item
                            istap.toggle()
                        }
                }
            }
        }
    }
}

struct HeaderSpotlightView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSpotlightView()
    }
}
