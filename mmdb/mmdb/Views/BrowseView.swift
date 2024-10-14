//
//  BrowseView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 19/06/24.
//

import SwiftUI

struct BrowseView: View {
    @ObservedObject var viewModel = PaperListViewModel()
    
    @State var searchText = ""
    
    var body: some View {
//            NavigationStack {
//                List(viewModel.recentPapers, id: \.paperId) { paper in
//                    NavigationLink(destination: PaperDetailView(mainPaper: paper)) {
//                        PaperView(paperViewModel: paper)
//                    }
//                }
//            }
//            .onAppear {
//                viewModel.fetchRecentPapers()
//            }
//            .navigationTitle(Text("Recent Papers"))
//        .searchable(text: $searchText, prompt: Text("Search papers from all fields of Science"))
//        .onChange(of: searchText) {
//            if searchText.isEmpty {
//                viewModel.emptySuggestedPapers()
//            } else {
//                if searchText.count > 4 {
//                    viewModel.fetchPapersByRelevance(query: searchText)
//                }
//                print(searchText)
//            }
//        }
//        .searchSuggestions {
//            ForEach(viewModel.suggestedPapers, id: \.paperId) { paper in
//                //                print(paper)
//                NavigationLink(destination: PaperDetailView(mainPaper: paper)) {
//                    Label(.init(paper.title), systemImage: "book.pages").onTapGesture {
//                        print("tapped")
//                    }
//                }
//                
//            }
//        }
        Text("s")
    }
}

#Preview {
    BrowseView()
}
