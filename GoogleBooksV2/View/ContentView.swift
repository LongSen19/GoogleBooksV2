//
//  ContentView.swift
//  GoogleBooks
//
//  Created by Long Sen on 7/22/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var googleBooks: GoogleBooks

    
    var body: some View {
        TabView {
            SearchTabView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            FavoriteBooksView()
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

