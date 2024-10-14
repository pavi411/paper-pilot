//
//  PaperListViewModel.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/28/24.
//

import Foundation
import Combine
import PDFKit


class PaperListViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let paperService = PaperService()
    @Published var papers: [PaperViewModel] = []
    @Published var suggestedPapers: [PaperViewModel] = []
    @Published var categoryStats: [CategoryViewModel] = []
    @Published var papersByCategory: [PaperViewModel] = []
    @Published var relatedPapers: [PaperViewModel] = []
    @Published var recentPapers: [PaperViewModel] = []
    
    func fetchPapersByIds(ids: [String]) {
        paperService.fetchPapersByIds(for: ids)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { papers in
                papers.enumerated().forEach { idx, paper in
                    print(paper.pdfLink)
                    if let link = paper.pdfLink, let url = URL(string: link) {
                        let images = self.convertPDFToImages(pdfURL: url, name: paper.paperId)
                        print(images, images?.count)
                        papers[idx].images = images ?? []
                    }
                }
                self.papers = papers
            }
            .store(in: &cancellables)
    }
    
    func convertPDFToImages(pdfURL: URL, name: String) -> [UIImage]? {
//        guard let pdfDocument = PDFDocument(url: pdfURL) else {
//            return nil
//        }
//        
//        
//        var images: [UIImage] = []
//        print(pdfDocument.pageCount)
//        
//        for pageNum in 0..<pdfDocument.pageCount {
//            if let pdfPage = pdfDocument.page(at: pageNum) {
//                let pdfPageSize = pdfPage.bounds(for: .mediaBox)
//                let renderer = UIGraphicsImageRenderer(size: pdfPageSize.size)
//                
//                let image = renderer.image { ctx in
//                    UIColor.white.set()
//                    ctx.fill(pdfPageSize)
//                    ctx.cgContext.translateBy(x: 0.0, y: pdfPageSize.size.height)
//                    ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
//                    
//                    pdfPage.draw(with: .mediaBox, to: ctx.cgContext)
//                }
//                
//                images.append(image)
//            }
//        }
//        
//        return images
//        
        
        
       
        print("convertPDFToImages: \(pdfURL)")
        let parameters = [Parameter(name: name, fileValue: FileValue(url: pdfURL.absoluteString))]
        let data = ["Parameters": parameters]
        let requestBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        print(requestBody)
        let endpoint = "/convert/pdf/to/png"
        let queryItems = [URLQueryItem(name: "Secret", value: "d4IwxULhcnqJdlC2")]

            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "v2.convertapi.com"
            urlComponents.path = endpoint
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
            var request = URLRequest(url: url)

            request.httpMethod = "POST"
            request.httpBody = requestBody

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            print(request)

            URLSession.shared.dataTaskPublisher(for: request)
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
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }) { papers in
                    papers.enumerated().forEach { idx, paper in
                        print(paper.pdfLink)
                        if let link = paper.pdfLink, let url = URL(string: link) {
                            let images = self.convertPDFToImages(pdfURL: url, name: paper.paperId)
                            print(images, images?.count)
                            papers[idx].images = images ?? []
                        }
                    }
                    self.papers = papers
                }
                .store(in: &cancellables)
        
    }
    
    func fetchPapersByRelevance(query: String) {
        paperService.fetchPapersByRelevance(with: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { papers in
                self.suggestedPapers = papers
            }
            .store(in: &cancellables)
    }
    
    func emptySuggestedPapers() {
        self.suggestedPapers = []
    }
    
    func fetchPaperStatsByCategory(for categories: [String]) {
        categories.forEach { cat in
            paperService.fetchPaperStatsByCategory(with: cat)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { category in
                var categoryCopy = category
                categoryCopy.title = cat
                categoryCopy.imageUrl = "compsci"
                self.categoryStats.append(categoryCopy)
                print(self.categoryStats)
            }
            .store(in: &cancellables)
         }
        
    }
    
    func fetchPapersForCategory(for category: String) {
            paperService.fetchPapersForCategory(for: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { paper in
                self.papersByCategory = paper
                print(self.papersByCategory)
            }
            .store(in: &cancellables)
    }
    
    func fetchRecentPapers() {
            paperService.fetchRecentPapers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { paper in
                self.recentPapers = paper
                print(self.recentPapers)
            }
            .store(in: &cancellables)
    }
    
    func fetchRelatedPapers(for paperId: String) {
        paperService.fetchRelatedPapers(for: paperId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { papers in
                self.relatedPapers = papers
            }
            .store(in: &cancellables)
    }
}

fileprivate struct Parameter {
    var name: String
    var fileValue: FileValue
}

fileprivate struct FileValue {
    var url: String
}
