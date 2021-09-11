//
//  BookView.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/19/21.
//

import SwiftUI

struct BookView: View {
    var book: Book
    
    var body: some View {
        HStack {
            AsyncImageView(stringURL: book.imageLink) {
                placeHolder
            }
            VStack(alignment: .leading) {
                Text("Title: ").foregroundColor(.blue) + Text(book.title)
                Text("Authors: ").foregroundColor(.blue) + Text(book.authors)
                RatingView(rating: book.rating)
            }
        }
    }
    
    
    var placeHolder: some View {
        ZStack {
            Color.white
            Text("No Image")
        }
    }
}

