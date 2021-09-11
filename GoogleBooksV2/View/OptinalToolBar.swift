//
//  OptinalToolBar.swift
//  GoogleBooksV3
//
//  Created by Long Sen on 8/20/21.
//

import SwiftUI

struct OptionalToolBar: ViewModifier {
    @EnvironmentObject var googleBooks: GoogleBooks
    @Environment(\.presentationMode) var presentationMode
    let isFavoriteBook: Bool
    let book: Book
    
    
    func body(content: Content) -> some View {
        Group {
            if isFavoriteBook {
                content
            } else {
                content
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Cancel")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Text("Add")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    googleBooks.addFavoriteBook(book)
                                    presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
            }
        }
    }
}



extension View {
    func optionalToolBar(isFavoriteBook: Bool, book: Book) -> some View {
        modifier(OptionalToolBar(isFavoriteBook: isFavoriteBook, book: book))
    }
}
