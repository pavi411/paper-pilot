//
//  PaperService.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation
import Combine

class PaperService {
    private let baseURL = "api.semanticscholar.org"
    
    func fetchPapersByIds(for ids: [String]) -> AnyPublisher<[PaperViewModel], Error> {
        print("fetchPapersByIds: \(ids)")
        let data = ["ids": ids]
        let requestBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        
        let endpoint = "/graph/v1/paper/batch"
        let queryItems = [URLQueryItem(name: "fields", value: "corpusId,title,venue,year,authors,abstract,citationCount,fieldsOfStudy,journal,publicationDate,tldr,openAccessPdf")]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.httpBody = requestBody

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                print(element)
                return element.data
            }
            .print()
            .decode(type: [PaperViewModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPapersByRelevance(with query: String) -> AnyPublisher<[PaperViewModel], Error> {
        print("fetchPapersByRelevance \(query)")
        let endpoint = "/graph/v1/paper/search"

        let queryItems = [URLQueryItem(name: "query", value: query), URLQueryItem(name: "fields", value: "corpusId,title,venue,year,authors,abstract,citationCount,fieldsOfStudy,journal,publicationDate,tldr,openAccessPdf"), URLQueryItem(name: "limit", value: "20")]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"

//        request.addValue("lpjKhL C7Tq7M3BJByEeVA2yT1coqq2XT19dcG4YP", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .print()
            .decode(type: PaperQuerySearch.self, decoder: JSONDecoder())
            .map { ele in
                print(ele)
                return ele.papers
            }
            .eraseToAnyPublisher()
    }
    
    func fetchPaperStatsByCategory(with category: String) -> AnyPublisher<CategoryViewModel, Error> {
        print("fetchPaperStatsByCategory \(category)")
        let endpoint = "/graph/v1/paper/search/bulk"
        let queryItems = [URLQueryItem(name: "fieldsOfStudy", value: category)]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"

//        request.addValue("lpjKhLC7Tq7M3BJByEeVA2yT1coqq2XT19dcG4YP", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .print()
            .decode(type: CategoryViewModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    func fetchPapersForCategory(for category: String) -> AnyPublisher<[PaperViewModel], Error> {
        print("fetchPapersForCategory \(category)")
        let endpoint = "/graph/v1/paper/search/bulk"
        let queryItems = [URLQueryItem(name: "fieldsOfStudy", value: category)]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .print()
            .decode(type: PaperQuerySearch.self, decoder: JSONDecoder())
            .map { ele in
                print(ele)
                return ele.papers
            }
            .eraseToAnyPublisher()
    }
    
    func fetchRecentPapers() -> AnyPublisher<[PaperViewModel], Error> {
        let endpoint = "/graph/v1/paper/search/bulk"
        let queryItems = [URLQueryItem(name: "year", value: "2024-2020")]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .print()
            .decode(type: PaperQuerySearch.self, decoder: JSONDecoder())
            .map { ele in
                print(ele)
                return ele.papers
            }
            .eraseToAnyPublisher()
    }
    
    
    func fetchRelatedPapers(for paperId: String) -> AnyPublisher<[PaperViewModel], Error> {
        print("fetchRelatedPapers \(paperId)")
        let endpoint = "/recommendations/v1/papers/forpaper/\(paperId)"
        let queryItems = [URLQueryItem(name: "fields", value: "corpusId,title,venue,year,authors,abstract,citationCount,fieldsOfStudy,journal,publicationDate,openAccessPdf"), URLQueryItem(name: "limit", value: "15")]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .print()
            .decode(type: PaperQuerySearch.self, decoder: JSONDecoder())
            .map { ele in
                print(ele)
                return ele.papers
            }
            .eraseToAnyPublisher()
    }
}

private class PaperQuerySearch: Decodable {
    let total: Int
    let token: String?
    let papers: [PaperViewModel]
    
    init(total: Int, token: String?, papers: [PaperViewModel]) {
        self.total = total
        self.token = token
        self.papers = papers
    }
    
    enum CodingKeys: CodingKey {
        case total
        case token
        case data
        case recommendedPapers
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total) ?? 0
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        var papers: [PaperViewModel] = []
        do {
            papers = try container.decode([PaperViewModel].self, forKey: .data)
        } catch {
            print(error)
            papers = try container.decode([PaperViewModel].self, forKey: .recommendedPapers)
        }
        self.papers = papers
    }
    
}
