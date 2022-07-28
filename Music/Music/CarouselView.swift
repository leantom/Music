//
//  CarouselView.swift
//  Music
//
//  Created by QuangHo on 28/07/2022.
//

import SwiftUI
struct Item: Identifiable {
    var id: Int
    var title: String
    var color: Color
    var titleColor: Color
}

class Store: ObservableObject {
    @Published var items: [Item]
    
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    // dummy data
    init() {
        items = []
        for i in 0...7 {
            let new = Item(id: i, title: "Item \(i)", color: colors[i], titleColor: .white)
            items.append(new)
        }
    }
    
    init(songs: [Datum]) {
        items = []
        var index = 0
        for i in songs {
            let new = Item(id: index,
                           title: i.attributes.name ?? "",
                           color: Color.hex(hex: i.attributes.artwork.bgColor ?? "ffffff"),
                           titleColor: Color.hex(hex: i.attributes.artwork.textColor1 ?? "ffffff"))
            items.append(new)
            index += 1
        }
    }
    
}

struct CarouselView: View {
        @Binding var songs: [Datum]
        @State private var store = Store()
        @State private var snappedItem = 0.0
        @State private var draggingItem = 0.0
        var widthItem = UIScreen.main.bounds.width - 80
    
        var body: some View {
            
            ZStack {
                ForEach(store.items) { item in
                    
                    // article view
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(item.color)
                        Text(item.title)
                            .foregroundColor(item.titleColor)
                            .font(.title2)
                            .padding()
                    }
                    .frame(width: widthItem, height: 200)
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                    .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                    .offset(x: myXOffset(item.id) , y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x: 5, y: 5)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = snappedItem + value.translation.width / (widthItem / 2)
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / (widthItem / 2)
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                            snappedItem = draggingItem
                        }
                    }
            )
            .onAppear() {
                store = Store(songs: songs)
            }
        }
        
        func distance(_ item: Int) -> Double {
            return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
        }
        
        func myXOffset(_ item: Int) -> Double {
            let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
            return sin(angle) * widthItem
        }
}

