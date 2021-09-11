//
//  RatingView.swift
//  GoogleBooks
//
//  Created by Long Sen on 8/12/21.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    var emptyStar = 5
    var fillStar = 0
    var isHalf = false
    
    init(rating: Double) {
        self.rating = rating
        if rating != -1 {
            fillStar = Int(rating)
            if Double(fillStar) + 0.5 == rating {
                isHalf = true
                emptyStar -= 1
            }
            emptyStar = emptyStar - Int(rating)
        }
    }
    
    var body: some View {
        Group {
            if rating == -1 {
                Text("No Rating")
            } else {
                HStack {
                    starView
                    halfStarView
                    emptyStarView
                }
            }
        }
    }
    
    var emptyStarView: some View {
        Group {
        if emptyStar >= 1 {
            ForEach(1..<emptyStar + 1, id:\.self) { _ in
                Image(systemName: "star")
                    .foregroundColor(.yellow)

            }
        }
        }
    }
    
    var starView: some View {
        ForEach(1..<fillStar + 1, id:\.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
        }
    }
    
    var halfStarView: some View {
        Group {
        if isHalf {
            Image(systemName: "star.lefthalf.fill")
                .foregroundColor(.yellow)
        }
    }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4.0)
    }
}
