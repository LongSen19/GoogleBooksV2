//
//  AsyncImageView.swift
//  AsyncImageView
//
//  Created by Long Sen on 7/28/21.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeHolder: Placeholder
    private var width: CGFloat = 90
    private var height: CGFloat = 130
    
    init(stringURL: String?, width: CGFloat? = nil, height: CGFloat? = nil, @ViewBuilder placeHolder: () -> Placeholder) {
        self.placeHolder = placeHolder()
        _loader = StateObject(wrappedValue: ImageLoader(stringURL: stringURL ?? nil))
        if let width = width, let height = height {
            self.width = width
            self.height = height
        }
    }
    
    var body: some View {
        content
            .onAppear {
               loader.load()
            }
    }
    
    private var content: some View {
        Group {
            if loader.loadingImage == true {
                ProgressView()
            }
            else if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeHolder
            }
        }.frame(width: width, height: height)
    }
}
