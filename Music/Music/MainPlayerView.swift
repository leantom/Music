//
//  MainPlayerView.swift
//  Music
//
//  Created by QuangHo on 30/06/2022.
//

import SwiftUI
import MediaPlayer

struct MainPlayerView: View {
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @State var song: Datum?
    @State var songs:[Datum] = []
    @State var genres:[GenresModel.Datum] = []
    
    @State var value: CGFloat = 0
    var maximumSlider:CGFloat = UIScreen.main.bounds.width - 30
    var minimumSlider:CGFloat = 0
    @State var isPause: Bool = false
    var timerForText = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentTime = 0
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
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
            
            Text(song?.attributes.name ?? "")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.top, 25)
            
            Text(song?.attributes.composerName ?? "")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            HStack() {
                Text("00:00")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                Spacer()
                Text(song?.attributes.duration ?? "")
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
                        // get value base on slider
                        if let song = song {
                            let percent = Double(self.value/maximumSlider) * 100
//                            let timeCurrent = percent * Double(song.attributes.durationInMillis)
                            print(musicPlayer.currentPlaybackTime)
//                            musicPlayer.currentPlaybackTime = TimeInterval(timeCurrent)
                        }
                    }
                }))
            }
            
            HStack(spacing: 25) {
                Button {
                    musicPlayer.skipToPreviousItem()
                    self.song = songs[musicPlayer.indexOfNowPlayingItem]
                    currentTime = 0
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
                    isPause.toggle()
                    isPause ? musicPlayer.pause() : musicPlayer.play()
                } label: {
                    Image(systemName: isPause ? "play.fill" : "pause.fill")
                        .font(.system(size: 14, weight:.bold))
                        .foregroundColor(.white)
                        .padding(.all, 25)
                        .background(Color("BlueButton"))
                        .clipShape(Circle())
                        .shadow(color: Color("BlueButton").opacity(0.4), radius: 10, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                }
                Button {
                    musicPlayer.skipToNextItem()
                    self.song = songs[musicPlayer.indexOfNowPlayingItem]
                    currentTime = 0
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
        .background(Color("GrayButton"))
        .onAppear {
            if let song = song {
                var ids = songs.compactMap { item in
                    item.id
                }
                ids.removeAll { id in
                    return id == song.id
                }
                ids.insert(song.id, at: 0)
                
                self.musicPlayer.setQueue(with: ids)
                
                self.musicPlayer.prepareToPlay()
                self.musicPlayer.play()
            }
            
        }
        .onReceive(timerForText) { _ in
            if let song = song,
               let duration = song.attributes.durationInMillis {
                currentTime += 1
                value = maximumSlider * CGFloat(currentTime) / CGFloat(duration/1000)
            }
            
            print(currentTime)
        }
    }
}

struct MainPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MainPlayerView()
    }
}
