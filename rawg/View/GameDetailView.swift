import SwiftUI

struct GameDetailView: View {
    let game: Game
    @StateObject private var viewModel = LocalSource()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageUrl = URL(string: game.backgroundImage) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                SwiftUI.Color.clear
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            }
                            .frame(width: 400, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack{
                        Text(game.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(game: game)
                        }) {
                            Image(systemName: viewModel.isFavorite(game: game) ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isFavorite(game: game) ? .red : .gray)
                                .font(.title)
                        }
                    }
                    Text(game.released)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Rating: \(game.roundedRating)")
                        .font(.headline)
                    
                    Text(game.descriptionRaw ?? "")
                        .font(.body)
                }
                .padding()
            }
        }.onAppear(){
            viewModel.loadGames()
        }
        .navigationTitle("Game Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}


