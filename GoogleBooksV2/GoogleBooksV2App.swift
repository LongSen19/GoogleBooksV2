//
//  GoogleBooksV2App.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/13/21.
//

import SwiftUI

@main
struct GoogleBooksV2App: App {
    @StateObject var googleBooks = GoogleBooks()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(googleBooks)
        }
    }
}
