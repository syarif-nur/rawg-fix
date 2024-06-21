import SwiftUI

struct GameFavortieList: View {
    @StateObject private var viewModel = LocalSource()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.games, id: \.id) { game in
                    NavigationLink(
                        destination: GameDetailView(game: Game(from: game))
                    ) {
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
                                Text("Rating: \(game.roundedRating)")
                                    .font(.caption)
                            }
                            .padding(.leading, 8)
                        }
                    }
                }
            }
            .navigationTitle("Games")
        }.onAppear(){
            viewModel.loadGames()
        }
    }
}
