//
//  ContentView.swift
//  NeumorphicMusic
//
//  Created by QuangHo on 26/06/2022.
//

import SwiftUI
import MediaPlayer

struct SongView: View {
    @State var item: Datum
    var widthScreen = UIScreen.main.bounds.width
    var heightScreen = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            
            AsyncImage(url: item.attributes.getURLArtWork())
                .frame(width: widthScreen - 50, height: 150)
                .aspectRatio(contentMode: .fit)
                .clipShape(Rectangle())
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 8, y: 8)
                .padding(.bottom, 10)
            Text(item.attributes.name ?? "")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 200, alignment: .center)
                .lineLimit(1)
                
        }
    }
}

struct ContentView: View {
    @State var isShowPlayer: Bool = false
    @State var isShowSearch: Bool = false
    
    @State var chartSongs: [Datum] = []
    @State var albums: [Datum] = []
    @State var genres: [GenresModel.Datum] = []
    @State var artists: [ArtistModel.ArtistDatum] = []
    
    @State private var searchText = ""
    var network = Network()
    @State private var shouldShowPlayer = false
    @State private var isFinishedLoadData = false
    
    @State var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    let columns = [
        GridItem(.fixed(200))
    ]
    
   
    // call api -> 
    var body: some View {
        NavigationView {
            
            if isShowSearch {
                SearchView()
                    .dissmissViewTouch {
                        withAnimation {
                            isShowSearch.toggle()
                        }
                    }
            } else {
                ScrollView(.vertical) {
                    
                    TopHomeView().doSearchTouch {
                        withAnimation {
                            isShowSearch.toggle()
                        }
                    }
                    
                    VStack {
                        HStack() {
                            Text("Top Chart Songs")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.all)
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: columns, spacing: 10) {
                                ForEach(chartSongs, id: \.self) { item in
                                    NavigationLink {
                                        MainPlayerView(song: item, songs: chartSongs)
                                            .navigationBarHidden(true)
                                    } label: {
                                        SongView(item: item)
                                            .scaleEffect()
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack() {
                            Text("Popular Artists")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.all)
                            Spacer()
                        }
                        if isFinishedLoadData {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: columns, spacing: 40) {
                                    ForEach(artists, id: \.self) { item in
                                        NavigationLink {
                                            if let albums = item.relationships.albums.data {
                                                ListSongView(ids: albums.map({$0.id})).navigationBarHidden(true)
                                            }
                                        } label: {
                                            VStack(alignment: .center) {
                                                AsyncImage(url: item.attributes.getURLArtWork())
                                                    .frame(width: 150, height: 150)
                                                    .aspectRatio(contentMode: .fit)
                                                    .clipShape(Rectangle())
                                                    .cornerRadius(10)
                                                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 8, y: 8)
                                                    .padding(.bottom, 10)
                                                
                                                Text(item.attributes.name)
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                    .frame(width: 100, alignment: .center)
                                                    .lineLimit(2)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack() {
                            Text("Genres")
                                .font(.caption)
                                .padding(.all)
                            Spacer()
                        }
                        
                        if isFinishedLoadData {
                            CarouselView(songs: $chartSongs, widthItem: UIScreen.main.bounds.width - 80)
                        }
                    }
                    
                }
                .padding(.top, 15)
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            Task {
                
                if let data = try await network.start() {
                    for item in data.songs {
                        chartSongs.append(contentsOf: item.data)
                    }
                    albums = data.albums[0].data
                    
                    genres = try await network.getGenres()
                    
                    artists = try await network.getArtist()
                    
                    isFinishedLoadData.toggle()
                }
                
            }
        }
    }
}

