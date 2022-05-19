//
//  GoogleBooks.swift
//  GoogleBooks
//
//  Created by Long Sen on 7/22/21.
//

import SwiftUI
import Combine
import Foundation

class GoogleBooks: ObservableObject {
    @Published var books: [Book] = []
    @Published var keyword = ""
    @Published var index = 0
    var subscriptions: Set<AnyCancellable> = []
    
    @Published var favoriteBooks: [Book] = []
    
    let favoriteBooksJSONURL = URL(fileURLWithPath: "FavoriteBooks", relativeTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    
    init() {
        $keyword
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .compactMap { word in
                let key = word.replacingOccurrences(of: " ", with: "%20")
                return URL(string: "https://www.googleapis.com/books/v1/volumes?&q=\(key)&startIndex=\(self.index)&maxResults=20")
            }
            .flatMap(fetchBooks)
            .receive(on: DispatchQueue.main)
            .assign(to: \.books, on: self)
            .store(in: &subscriptions)
        
        $index
            .compactMap { index in
                return URL(string: "https://www.googleapis.com/books/v1/volumes?&q=\(self.keyword)&startIndex=\(index)&maxResults=20")
            }
            .flatMap(fetchBooks)
            .receive(on: DispatchQueue.main)
            .assign(to: \.books, on: self)
            .store(in: &subscriptions)
        
        loadFavoriteBooks()
        
        autosaveCancellable = $favoriteBooks.sink { favoriteBooks in
            do {
                let booksData = try JSONEncoder().encode(favoriteBooks)
                print("Test commit 2")
                try booksData.write(to: self.favoriteBooksJSONURL, options: .atomicWrite)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    private var autosaveCancellable: AnyCancellable?
    
    private func loadFavoriteBooks() {
        guard FileManager.default.fileExists(atPath: favoriteBooksJSONURL.path) else {
          return
        }
        
        do {
            let booksData = try Data(contentsOf: favoriteBooksJSONURL)
            favoriteBooks = try JSONDecoder().decode([Book].self, from: booksData)
        } catch let error {
            print(error)
        }
    }
    
    func addFavoriteBook(_ book: Book) {
        guard !favoriteBooks.contains(where: { $0.id == book.id }) else { return }
        favoriteBooks.append(book)
    }
    
    
    
    func fetchBooks(for url: URL) -> AnyPublisher<[Book], Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Books.self, decoder: JSONDecoder())
            .map(\.items)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func remove(at offsets: IndexSet) {
        favoriteBooks.remove(atOffsets: offsets)
    }
    
    func remove(_ book: Book) {
        if let index = favoriteBooks.firstIndex(where: { $0.id == book.id }) {
            favoriteBooks.remove(at: index)
        }
    }
    
    
}


enum HTTPError: LocalizedError {
    case statusCode
    case post
}

struct Post: Codable {

    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct Todo: Codable {

    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
}
