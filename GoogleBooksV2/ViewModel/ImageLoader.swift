//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by Long Sen on 7/28/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    var loadingImage = false
    
    
    init(stringURL: String?) {
        if stringURL != nil {
            loadingImage = true
            self.url = URL(string: stringURL!)
            print("test commit 1")
        } else {
            self.url = nil
        }
    }
    

    private var cancellable: AnyCancellable?
    
    func load() {
        if url != nil {
            cancellable = URLSession.shared.dataTaskPublisher(for: url!)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.image = $0
                        self?.loadingImage = false
                    }
        }
    }
    
    
    func cancel() {
        cancellable?.cancel()
    }
}

enum FetchError: Error {
    case badID
    case badImage
}
