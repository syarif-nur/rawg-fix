import Foundation

// MARK: - GameResult
struct GameResult: Codable {
    let status: String
    let results: [Game]
}

// MARK: - Game
struct Game: Codable, Identifiable {
    let id: Int
    let slug, name, released: String
    let backgroundImage: String
    let rating: Double
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case descriptionRaw = "description_raw"
    }

    var imageUrl: URL? {
        return URL(string: backgroundImage)
    }
    
    var roundedRating: String {
        String(format: "%.1f", rating)
    }
}
