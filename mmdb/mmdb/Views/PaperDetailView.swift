//
//  PaperDetailView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct PaperDetailView: View {
    @ObservedObject var viewModel = PaperListViewModel()
    let mainPaper: PaperViewModel?
    let columns = [
            GridItem(.adaptive(minimum: 90))
        ]
    let authorCount: Int = 5
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("DOI: " + (mainPaper?.doi ?? "")).foregroundStyle(Color(red: 136/255, green: 138/255, blue: 139/255)).font(.footnote)
                    Text("Corpus ID: " + String(mainPaper?.corpusId ?? 0)).foregroundStyle(Color(red: 136/255, green: 138/255, blue: 139/255)).font(.footnote)
                    HStack(alignment: .top) {
                        Text(mainPaper?.title ?? "no-title").frame(maxWidth: .infinity, alignment: .leading).font(.title).bold()
                    }

                        if mainPaper?.authors.count ?? 0 > authorCount {
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach (0..<authorCount) {
                                    Text(mainPaper?.authors[$0].name ?? "").font(.custom("some", size: 10)).lineLimit(1)
                                }
                                Text("+\((mainPaper?.authors.count ?? 0) - authorCount) authors").font(.custom("some", size: 10)).lineLimit(1)
                            }.padding(0).frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(mainPaper?.authors ?? [AuthorViewModel(authorId: "123", name: "Chandra Bhagyalakshmi"), AuthorViewModel(authorId: "1234", name: "olaaaaaaaa"), AuthorViewModel(authorId: "1236", name: "olaaaaaaaa"), AuthorViewModel(authorId: "1238", name: "olaaaaaaaa")], id: \.authorId) { author in
                                    Text(author.name).font(.custom("some", size: 10)).lineLimit(1)
                                }
                            }.padding(0).frame(maxWidth: .infinity, alignment: .center)
                        }
                    HStack(alignment: .center) {
                            VStack {
                                Text(String(mainPaper?.numCitations ?? 134) + " citations").frame(maxWidth: .infinity, alignment: .center).font(.title2).multilineTextAlignment(.center)}.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)).background(Color(white: 0.9)).cornerRadius(10)
                            Rectangle()
                            .fill(Color(white: 0.8))
                                            .frame(width: 1)
                            VStack {
                                Text("View Paper").frame(maxWidth: .infinity, alignment: .center).font(.title3).multilineTextAlignment(.center)                        }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10)).background(Color(white: 0.9)).cornerRadius(15).frame(maxWidth: .infinity, alignment: .trailing)
                        }.frame(maxWidth: .infinity, alignment: .trailing).background(Color(white: 0.9)).cornerRadius(10)
                    
                    Text("Published in " + (mainPaper?.pubVenue ?? "abc venue")).font(.custom("som2", size: 13))
                    Text(mainPaper?.category ?? "").font(.title3)
                    Spacer()
                    Text("Abstract").font(.custom("som2", size: 13)).underline()
                    Text(mainPaper?.abstract ?? "abc").font(.custom("som2", size: 12))
                    Spacer()
                    Text("Related papers").font(.title3).underline()
                    VStack(alignment: .leading) {
                        ForEach(viewModel.relatedPapers, id: \.self.paperId) { paper in
                            PaperView(paperViewModel: paper)
                            Rectangle()
                                                .fill(.secondary)
                                                .frame(height: 1)
                        }
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color(white: 0.95)).cornerRadius(20)
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
        }
        .onAppear {
            viewModel.fetchRelatedPapers(for: mainPaper?.paperId ?? "")
        }
    }
}
//
//#Preview {
//    PaperDetailView(mainPaper: .none)
//}
