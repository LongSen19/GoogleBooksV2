//
//  Books.swift
//  GoogleBooksV2
//
//  Created by Long Sen on 8/13/21.
//


import Foundation

struct Books: Codable {
    let totalItems: Int
    var items: [Book]
}


struct Book: Codable, Identifiable{
    let id: String
    let volumeInfo: VolumeInfo
    

    struct VolumeInfo: Codable {
        let title: String?
        let publisher: String?
        let authors: [String]?
        let averageRating: Double?
        let categories: [String]?
        let description: String?
        let imageLinks: ImageLink?
        
        struct ImageLink: Codable {
            let smallThumbnail: String
        }

    }
    
    var title: String {
        return volumeInfo.title ?? ""
    }
    
    var publisher: String {
        return volumeInfo.publisher ?? ""
    }
    
    var authors: String {
        return arrayString(volumeInfo.authors)
    }
    
    var rating: Double {
        return volumeInfo.averageRating ?? -1
    }
    
    var categories: String {
        return arrayString(volumeInfo.categories)
    }
    
    var description: String {
        return volumeInfo.description ?? ""
    }
    
    var imageLink: String? {
        return volumeInfo.imageLinks?.smallThumbnail
    }
    
    private func arrayString(_ contest: [String]?) -> String {
        var result = ""
        if contest != nil {
            for piece in contest! {
                result += piece
                if piece != contest!.last {
                    result += ","
                }
            }
        }
        return result
    }
    
}


