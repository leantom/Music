//
//  ContentView.swift
//  NeumorphicMusic
//
//  Created by QuangHo on 26/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var value: CGFloat = 50
    var maximumSlider:CGFloat = UIScreen.main.bounds.width - 30
    var minimumSlider:CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        
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
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 10)
                .clipShape(Circle())
                .padding(.all, 8)
                .background(Color("GrayButton").opacity(0.6))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 8, y: 8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                .padding(.top, 35)
            
            Text("Lose it")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.top, 25)
            
            Text("Flume ft Vic monica")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            HStack() {
                Text("1:12")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                Spacer()
                Text("4:22")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
            }
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 6)
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                    Capsule()
                        .fill(Color("BlueButton").opacity(0.6))
                        .frame(width:value, height: 6)
                    Circle()
                        .fill(Color("BlueButton").opacity(0.7))
                        .frame(width: 10, height: 10)
                        .padding(.all, 10)
                        .background(Color("GrayButton"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 5, y: 5)
                    
                    
                }
                .gesture(DragGesture().onChanged({ value in
                    // MARK: limit
                    if value.location.x < maximumSlider && value.location.x > minimumSlider {
                        self.value = value.location.x
                    }
                    
                }))
            }
            
            HStack(spacing: 25) {
                Button {
                    
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 14, weight:.bold))
                        .foregroundColor(.gray)
                        .padding(.all, 25)
                        .background(Color("GrayButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.4), radius: 10, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                }
                Button {
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 14, weight:.bold))
                        .foregroundColor(.white)
                        .padding(.all, 25)
                        .background(Color("BlueButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.4), radius: 10, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                }
                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 14, weight:.bold))
                        .foregroundColor(.gray)
                        .padding(.all, 25)
                        .background(Color("GrayButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.4), radius: 10, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                }
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding(.all)
        .background(Color("GrayButton")).edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
