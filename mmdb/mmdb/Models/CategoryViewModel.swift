//
//  CategoryViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation

struct CategoryViewModel: Hashable {
    let title: String
    let paperCount: Int
    let imageUrl: String
    
    init(title: String, paperCount: Int, imageUrl: String) {
        self.title = title
        self.paperCount = paperCount
        self.imageUrl = imageUrl
    }
}
