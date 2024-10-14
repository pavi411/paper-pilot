//
//  CategoryView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct CategoryView: View {
    let data: [CategoryViewModel] = [.init(title: "testing", paperCount: 3, imageUrl: "compsci"), .init(title: "tesing", paperCount: 3, imageUrl: "compsci"), .init(title: "teing", paperCount: 3, imageUrl: "compsci")]
    let categories = ["Computer Science", "Medicine", "Chemistry", "Biology", "Materials Science", "Physics", "Geology", "Psychology", "Art", "History", "Geography", "Sociology", "Business", "Political Science", "Economics", "Philosophy", "Mathematics", "Engineering", "Environmental Science", "Agricultural and Food Sciences", "Education", "Law", "Linguistics"]
    
    @ObservedObject var viewModel = PaperListViewModel()
    
    @State var isCategoryTapped: Bool = false
    
    let columns = [
            GridItem(.adaptive(minimum: 120))
        ]
    
    func routeToPaperListView(category: String) {
        viewModel.fetchPapersForCategory(for: category)
    }
    
    var body: some View {
        return Group {
            if !isCategoryTapped {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.categoryStats, id: \.self) { category in
                            VStack(alignment: .center) {
                                Image(uiImage: .init(resource: .init(name: category.imageUrl, bundle: .main)))
                                    .resizable()
                                    .frame(height: 128)
                                Text(category.title)
                                Text(String(category.paperCount))
                            }
                            .onTapGesture {
                                isCategoryTapped = true
                                routeToPaperListView(category: category.title)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    .onAppear {
                        viewModel.fetchPaperStatsByCategory(for: categories)
                    }
                }
                .frame(width: .infinity)
            } else {
//                Text("hello")
                List(viewModel.papersByCategory, id: \.paperId) { paper in
                    PaperView(paperViewModel: paper)
                }
            }
        }
    }
}

//#Preview {
//    CategoryView()
//}
