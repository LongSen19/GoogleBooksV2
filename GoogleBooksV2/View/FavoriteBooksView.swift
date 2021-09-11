//
//  FavoriteBooksView.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/19/21.
//

import SwiftUI

struct FavoriteBooksView: View {
    @EnvironmentObject private var googleBooks: GoogleBooks
    @State var hiddenSeachView = false

    
    var body: some View {
        NavigationView {
            List {
                ForEach(googleBooks.favoriteBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book, isFavoriteBook: true)) {
                        BookView(book: book)
                        
                    }.listRowBackground(Color.green)
                }.onDelete(perform: googleBooks.remove(at:))
            }.navigationBarTitle("Favorite Books", displayMode: .inline)
        }
    }
}

struct FavoriteBooksView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteBooksView()
    }
}
