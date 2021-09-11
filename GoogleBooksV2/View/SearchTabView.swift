//
//  SearchTabView.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/19/21.
//

import SwiftUI

struct SearchTabView: View {
    @EnvironmentObject private var googleBooks: GoogleBooks
    @State var selectedBook: Book?
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            VStack(spacing: 0){
                searchView
                List {
                    ForEach(googleBooks.books) { book in
                        BookView(book: book)
                            .onTapGesture {
                                selectedBook = book
                            }
                    }
                }
                optionalPaginationView
            }
            .sheet(item: $selectedBook) { book in
                BookDetailView(book: book, isFavoriteBook: false)
            }
        }
    }
    
    
    var optionalPaginationView: some View {
        Group {
            if googleBooks.books.count != 0 {
                paginationButton
            }
        }.padding()
    }
    
    
    var searchView: some View {
        HStack {
            TextField("Enter words to search books", text: $googleBooks.keyword)
        }
        .padding()
    }
    
    var nextButton: some View {
        Button("Next") {
            googleBooks.index += 20
        }
        .disabled(googleBooks.books.count == 0)
        .opacity(googleBooks.books.count == 0 ? 0 : 1 )
    }
    
    var previousButton: some View {
        Button("Previous") {
            if googleBooks.index > 19 {
                googleBooks.index -= 20
            }
        }
    }
    
    var paginationButton: some View {
        Group {
            if googleBooks.index >= 20 {
                HStack {
                    previousButton
                    nextButton
                }
            } else {
                nextButton
            }
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
