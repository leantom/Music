//
//  SearchView.swift
//  Music
//
//  Created by QuangHo on 31/07/2022.
//

import SwiftUI
import Combine

class SearchBarViewModel: ObservableObject {
    @Published var text: String = ""
    var network = Network()
    @Published var songs = [Datum]()
    
    func getSong() async throws {
        let songs = try await network.search(text: text)
        
        DispatchQueue.main.async {
            self.songs.append(contentsOf: songs)
            print("songs: \(songs.count)")
        }
        
    }
    
}

struct SearchView: View {
    @State var isFinished : Bool = false
    @StateObject private var vm = SearchBarViewModel()
    var dissmissView : () -> Void = {}
    var network = Network()
    
    func dissmissViewTouch(action: @escaping () -> Void) -> Self {
        var newOne = self
        newOne.dissmissView = action
        return newOne
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack() {
                HStack() {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .foregroundColor(Color.green)
                    TextField("Search", text: $vm.text,onEditingChanged: { finished in
                        if finished {
                            print("finished")
                        } else {
                            print("not finished")
                        }
                        
                    }, onCommit: {
                        print("commit")
                    }
                    )
                    .tint(.yellow)
                    .foregroundColor(Color.black)
                    .onReceive(
                                        vm.$text
                                            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
                                    ) {
                                        guard !$0.isEmpty else { return }
                                        print(">> searching for: \($0)")
                                        Task {
                                            try await vm.getSong()
                                            isFinished.toggle()
                                        }
                                    }
                        
                    Spacer()
                    Image(systemName: "x.circle")
                        .padding()
                        .foregroundColor(Color.green)
                        .onTapGesture {
                            dissmissView()
                        }
                    
                }
                .background(Color.gray.opacity(0.2))
                .frame(height: 50)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                .transition(.move(edge: .bottom))
                
                HeaderSpotlightView()
                    .frame(height:50)
                    .padding()
                Spacer()
                ForEach(vm.songs) { song in
                    NavigationLink {
                        
                    } label: {
                        HStack (alignment: .center) {
                            HStack {
                                
                                AsyncImage(url: song.attributes.getURLArtWork())
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(20)
                                    .padding(.trailing, 10)
                                VStack(alignment: .leading) {
                                    Text(song.attributes.name ?? "")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Text(song.attributes.artistName ?? "")
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
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
