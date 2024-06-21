import Foundation
import RealmSwift

class LocalSource: ObservableObject {
    @Published var games: [RealmGame] = []
    private var realm: Realm?
    
    init() {
        do {
            self.realm = try Realm()
            if let realm = realm {
                print("Realm database path: \(realm.configuration.fileURL?.path ?? "No Path")")
            }
            loadGames()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    func loadGames() {
        do {
            if let realm = realm {
                let realmGames = realm.objects(RealmGame.self).filter("isFavorite == true")
                self.games = Array(realmGames)
                print("Loaded \(self.games.count) favorite games from Realm.")
            }
        } catch {
            print("Error loading games from Realm: \(error)")
        }
    }
    
    func addGame(game: Game) {
        do {
            try realm?.write {
                if let existingRealmGame = realm?.object(ofType: RealmGame.self, forPrimaryKey: game.id) {
                    existingRealmGame.isFavorite = true
                } else {
                    let realmGame = RealmGame(from: game)
                    realmGame.isFavorite = true
                    realm?.add(realmGame)
                }
            }
            loadGames()
        } catch {
            print("Error updating game in Realm: \(error)")
        }
    }
    
    
    func deleteGame(game: RealmGame) {
        do {
            try realm?.write {
                game.isFavorite = false
            }
            loadGames()
        } catch {
            print("Error updating game in Realm: \(error)")
        }
    }
    
    
    func isFavorite(game: Game) -> Bool {
        return games.contains(where: { $0.id == game.id })
    }
    
    func toggleFavorite(game: Game) {
        if let realmGame = games.first(where: { $0.id == game.id }) {
            deleteGame(game: realmGame)
        } else {
            addGame(game: game)
        }
    }
}
