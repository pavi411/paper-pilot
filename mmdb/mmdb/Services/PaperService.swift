//
//  PaperService.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import Foundation
import Combine

class PaperService {
    private let baseURL = URL(string: "")!
    func fetchTodos() -> AnyPublisher<[PaperViewModel], Error> {
        URLSession.shared.dataTaskPublisher(for: baseURL)
            .map(\.data)
            .decode(type: [PaperViewModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
