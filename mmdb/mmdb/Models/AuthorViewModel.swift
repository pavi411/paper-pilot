//
//  AuthorViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation

struct AuthorViewModel: Hashable, Decodable {
    let authorId: String
    let name: String
    
    init(authorId: String, name: String) {
        self.authorId = authorId
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case authorId
        case name
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authorId = try container.decodeIfPresent(String.self, forKey: .authorId) ?? ""
        self.name = try container.decode(String.self, forKey: .name)
    }
}
