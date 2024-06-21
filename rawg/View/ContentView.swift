//
//  ContentView.swift
//  rawg
//
//  Created by Syarif on 26/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            GameFavortieList()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}
