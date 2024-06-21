//
//  Game.swift
//  rawg
//
//  Created by Syarif on 20/06/24.
//

import Foundation

import RealmSwift

class RealmGame: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var slug: String = ""
    @Persisted var name: String = ""
    @Persisted var released: String = ""
    @Persisted var backgroundImage: String = ""
    @Persisted var rating: Double = 0.0
    @Persisted var descriptionRaw: String? = nil
    @Persisted var isFavorite: Bool = false
    
    var imageUrl: URL? {
        URL(string: backgroundImage)
    }

    var roundedRating: String {
        String(format: "%.1f", rating)
    }

    convenience init(id: Int, slug: String, name: String, released: String, backgroundImage: String, rating: Double, descriptionRaw: String?) {
        self.init()
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.descriptionRaw = descriptionRaw
    }
}


extension Game {
    init(from realmGame: RealmGame) {
        self.id = realmGame.id
        self.slug = realmGame.slug
        self.name = realmGame.name
        self.released = realmGame.released
        self.backgroundImage = realmGame.backgroundImage
        self.rating = realmGame.rating
        self.descriptionRaw = realmGame.descriptionRaw
    }
}

extension RealmGame {
    convenience init(from game: Game) {
        self.init()
        self.id = game.id
        self.slug = game.slug
        self.name = game.name
        self.released = game.released
        self.backgroundImage = game.backgroundImage
        self.rating = game.rating
        self.descriptionRaw = game.descriptionRaw
    }
}
