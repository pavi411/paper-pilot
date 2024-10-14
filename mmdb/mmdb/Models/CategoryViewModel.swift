//
//  CategoryViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation

struct CategoryListViewModel {
    let categoryList: [CategoryViewModel]
    
    init(categoryList: [CategoryViewModel]) {
        self.categoryList = categoryList
    }
}

struct CategoryViewModel: Hashable, Decodable {
    var title: String
    var paperCount: Int
    var imageUrl: String
    
    init(title: String, paperCount: Int, imageUrl: String) {
        self.title = title
        self.paperCount = paperCount
        self.imageUrl = imageUrl
    }
    
    enum CodingKeys: CodingKey {
        case title
        case total
        case imageUrl
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.paperCount = try container.decode(Int.self, forKey: .total)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? "compsci"
    }
}
