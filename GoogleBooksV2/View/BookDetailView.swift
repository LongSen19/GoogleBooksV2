//
//  BookDetailView.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/13/21.
//

import SwiftUI

struct BookDetailView: View {
    
    @EnvironmentObject var googleBooks: GoogleBooks
    var book: Book
    var isFavoriteBook: Bool
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView {
        VStack {
            Spacer()
            AsyncImageView(stringURL: book.imageLink, width: 150, height: 200) {
                placeHolder
            }
            RatingView(rating: book.rating)
            
            Form {
                Section(header: Text("Authors")) {
                    Text(book.authors)
                }
                Section(header: Text("Publishers")) {
                    Text(book.publisher)
                }
                Section(header: Text("Categories")) {
                    Text(book.categories)
                }
                Section(header: Text("Description")) {
                    Text(book.description)
                }
                addOrDeleteBook
            }
        }.navigationBarTitle(book.title, displayMode: .inline)
        .optionalToolBar(isFavoriteBook: isFavoriteBook, book: book)

    }
    }
    
    var addOrDeleteBook: some View {
        Group {
            Section {
                if !isFavoriteBook {
                    Button("Add") {
                        googleBooks.addFavoriteBook(book)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                } else {
                    Button("Delete") {
                        googleBooks.remove(book)
                        presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.red)
                }
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var placeHolder: some View {
        ZStack {
            Color.white
            Text("No Image")
        }
    }
}

