//
//  ListSongView.swift
//  Music
//
//  Created by QuangHo on 30/07/2022.
//

import SwiftUI
import Foundation

struct ListSongView: View {
    @Environment(\.presentationMode) var presentation
    @State var songs: [AlbumModel.ArtistsDatum] = []
    @State var songsTransfer:[Datum] = []
    @State var ids: [String] = []
    
    var network = Network()
    var body: some View {
        NavigationView {
            VStack {
                
                HeaderView(presentation: _presentation)
                    .padding()
               
                ScrollView(.vertical) {
                    ForEach(songs) { song in
                        NavigationLink {
                            MainPlayerView(song: Datum(songAlbum: song), songs: self.songsTransfer)
                                .navigationBarHidden(true)
                        } label: {
                            HStack (alignment: .center) {
                                HStack {
                                    
                                    AsyncImage(url: song.attributes!.getURLArtWork())
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(20)
                                        .padding(.trailing, 10)
                                    VStack(alignment: .leading) {
                                        Text(song.attributes?.name ?? "")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                        Text(song.attributes?.artistName ?? "")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                HStack {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "play.circle.fill")
                                            .foregroundColor(.green)
                                    }

                                    Button {
                                        
                                    } label: {
                                       Text("more")
                                            .font(.caption2)
                                            .fontWeight(.light)
                                    }
                                    
                                }
                            }
                            .padding()
                        }
                        
                    }
                }
            }.navigationBarHidden(true)
        }.onAppear {
            Task {
                let data =  try await network.getSongFromAlbums(ids: ids.joined(separator: ","))
                
                for item in data {
                    if let tracks = item.relationships?.tracks?.data {
                        for song in tracks {
                            songs.append(song)
                            songsTransfer.append(Datum(songAlbum: song))
                        }
                    }
                }
            }
            
        }
        
    }
}

struct ListSongView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListSongView()
    }
}
