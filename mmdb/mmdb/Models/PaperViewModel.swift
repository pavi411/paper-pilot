//
//  PaperViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation
import UIKit

class PaperViewModel: Decodable {
    
    static func == (lhs: PaperViewModel, rhs: PaperViewModel) -> Bool {
        return true
    }
    
    let paperId: String
    let title: String
    let numCitations: Int
    let abstract: String?
    let pubDate: String?
    let pubVenue: String?
    let category: String
    let pdfLink: String?
    let doi: String?
    let corpusId: Int?
    let authors: [AuthorViewModel]
    let tldr: String?
    var isFav: Bool
    var favPaper: FavouritePaper?
    var images: [UIImage]
    
    init(paperId: String, title: String, numCitations: Int = 0, abstract: String?, pubDate: String?, pubVenue: String?, category: String, pdfLink: String?, doi: String?, corpusId: Int?, authors: [AuthorViewModel] = [], tldr: String?) {
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
        self.tldr = tldr
        self.isFav = false
        self.images = []
    }
    
    enum CodingKeys: CodingKey {
        case paperId
        case title
        case citationCount
        case abstract
        case publicationDate
        case venue
        case fieldsOfStudy
        case pdfLink
        case doi
        case corpusId
        case authors
        case tldr
        case isFav
        case openAccessPdf
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.paperId = try container.decode(String.self, forKey: .paperId)
        self.title = try container.decode(String.self, forKey: .title)
        self.numCitations = try container.decodeIfPresent(Int.self, forKey: .citationCount) ?? 0
        self.abstract = try container.decodeIfPresent(String.self, forKey: .abstract)
        self.pubDate = try container.decodeIfPresent(String.self, forKey: .publicationDate)
        self.pubVenue = try container.decodeIfPresent(String.self, forKey: .venue)
        let cats = try container.decodeIfPresent([String].self, forKey: .fieldsOfStudy)
        if let categories = cats?.joined(separator: ",") {
            self.category = categories
        } else {
            self.category = ""
        }
        let opdf = try container.decodeIfPresent(OpenAccessPDF.self, forKey: .openAccessPdf)
        print(opdf)
        self.pdfLink = opdf?.url
        self.doi = try container.decodeIfPresent(String.self, forKey: .doi)
        self.corpusId = try container.decodeIfPresent(Int.self, forKey: .corpusId)
        self.authors = try container.decodeIfPresent([AuthorViewModel].self, forKey: .authors) ?? []
//        self.tldr = try container.decodeIfPresent(String.self, forKey: .tldr)
        self.isFav = try container.decodeIfPresent(Bool.self, forKey: .isFav) ?? false
        self.tldr = ""
        self.images = []
        
    }
    
    func getAuthors() -> String {
        var authorStr = ""
        for i in 0..<min(authors.count, 4) {
            authorStr += authors[i].name
        }
        return authorStr
    }
    
    func updateFavPaper(fav: FavouritePaper) {
        favPaper = fav
    }
}

fileprivate class OpenAccessPDF: Decodable {
    let url: String?
    let status: String?
    
    enum CodingKeys: CodingKey {
        case url
        case status
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
    }
    
}
