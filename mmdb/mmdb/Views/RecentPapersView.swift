//
//  RecentPapersView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI
import PDFKit

struct RecentPapersView: View {
    @ObservedObject var viewModel = PaperListViewModel()
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favPapers: FetchedResults<FavouritePaper>
    
    @State var searchText = ""
    
    func getIds() -> [String] {
        var paperIds: [String] = []
        favPapers.forEach { paper in
            paperIds.append(paper.paperId)
        }
        paperIds.append("649def34f8be52c8b66281af98ae884c09aef38b")
        return paperIds
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            VStack(alignment: .leading) {
                NavigationStack {
                    List(viewModel.papers, id: \.paperId) { paper in
                        NavigationLink(destination: PaperDetailView(mainPaper: paper)) {
                            PaperView(paperViewModel: paper)
                        }
                    }.listRowSeparator(.hidden)
                }
                .onAppear {
                    viewModel.fetchPapersByIds(ids: getIds())
//                    sleep(10)
                    
                }
                .navigationTitle(Text("My Papers"))
            }
            .searchable(text: $searchText, prompt: Text("Search papers from all fields of Science"))
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    viewModel.emptySuggestedPapers()
                } else {
                    if searchText.count > 4 {
                        viewModel.fetchPapersByRelevance(query: searchText)
                    }
                    print(searchText)
                }
            }
            .searchSuggestions {
                ForEach(viewModel.suggestedPapers, id: \.paperId) { paper in
                    //                print(paper)
                    NavigationLink(destination: PaperDetailView(mainPaper: paper)) {
                        Label(.init(paper.title), systemImage: "book.pages").onTapGesture {
                            print("tapped")
                        }
                    }
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

//#Preview {
//    RecentPapersView()
//}
