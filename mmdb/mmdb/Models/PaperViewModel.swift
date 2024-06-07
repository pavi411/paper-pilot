//
//  PaperViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation

struct PaperViewModel: Hashable, Decodable {
    let paperId: String
    let title: String
    let numCitations: Int
    let abstract: String?
    let pubDate: String?
    let pubVenue: String?
    let category: String
    let pdfLink: String?
    let doi: String?
    let corpusId: String?
    let authors: [AuthorViewModel]
    
    init(paperId: String, title: String, numCitations: Int, abstract: String?, pubDate: String?, pubVenue: String?, category: String, pdfLink: String?, doi: String?, corpusId: String?, authors: [AuthorViewModel]) {
        self.paperId = paperId
        self.title = title
        self.numCitations = numCitations
        self.abstract = abstract
        self.pubDate = pubDate
        self.pubVenue = pubVenue
        self.category = category
        self.pdfLink = pdfLink
        self.doi = doi
        self.corpusId = corpusId
        self.authors = authors
    }
    
    enum CodingKeys: CodingKey {
        case paperId
        case title
        case numCitations
        case abstract
        case pubDate
        case pubVenue
        case category
        case pdfLink
        case doi
        case corpusId
        case authors
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.paperId = try container.decode(String.self, forKey: .paperId)
        self.title = try container.decode(String.self, forKey: .title)
        self.numCitations = try container.decode(Int.self, forKey: .numCitations)
        self.abstract = try container.decodeIfPresent(String.self, forKey: .abstract)
        self.pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate)
        self.pubVenue = try container.decodeIfPresent(String.self, forKey: .pubVenue)
        self.category = try container.decode(String.self, forKey: .category)
        self.pdfLink = try container.decodeIfPresent(String.self, forKey: .pdfLink)
        self.doi = try container.decodeIfPresent(String.self, forKey: .doi)
        self.corpusId = try container.decodeIfPresent(String.self, forKey: .corpusId)
        self.authors = try container.decode([AuthorViewModel].self, forKey: .authors)
    }
    
}
