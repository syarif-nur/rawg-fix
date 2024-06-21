import SwiftUI

struct GameListView: View {
    @StateObject private var viewModel = NetworkSource()
    
    var body: some View {
        NavigationView {
            VStack {
                if let gameResult = viewModel.body {
                    List(gameResult.results) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            HStack(alignment: .top) {
                                if let imageUrl = game.imageUrl {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 100, height: 100)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(game.name)
                                        .font(.headline)
                                    Text(game.released)
                                        .font(.subheadline)
                                    Text("Rating: \(game.roundedRating)"  )
                                        .font(.caption)
                                }
                                .padding(.leading, 8)
                            }
                        }
                    }
                } else {
                    VStack {
                        ProgressView()
                        Text("Loading...")
                    }
                    .onAppear {
                        viewModel.fetchRemoteData()
                    }
                }
            }
            .navigationTitle("Games")
        }
    }
}
