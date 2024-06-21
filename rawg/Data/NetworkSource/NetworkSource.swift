//
//  NetworkSource.swift
//  rawg
//
//  Created by Syarif on 20/06/24.
//

import Foundation

class NetworkSource: ObservableObject {
    @Published public var gameResult: GameResult?
    
    var body: GameResult? {
        return gameResult
    }
    
    func fetchRemoteData() {
        let url = URL(string: "https://rawg-mirror.vercel.app/api/games")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(GameResult.self, from: data)
                DispatchQueue.main.async {
                    self.gameResult = decodedData
                }
            } catch {
                print("Failed to decode JSON:", error)
            }
        }
        
        task.resume()
    }
}
