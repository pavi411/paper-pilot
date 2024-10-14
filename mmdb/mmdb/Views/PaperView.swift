//
//  PaperView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct PaperView: View {
    
    var paperViewModel: PaperViewModel
    let authorCount = 5
    
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favPapers: FetchedResults<FavouritePaper>

    var body: some View {
        VStack(alignment: .center) {
            Text(paperViewModel.title).padding(EdgeInsets(top: 5, leading: 5, bottom: 1, trailing: 5)).font(.title).bold().foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.7))
            if let image = paperViewModel.images.first {
                Image(uiImage: image)
            }
            
            if paperViewModel.authors.count > authorCount {
                LazyVGrid(columns: columns, spacing: 3) {
                    ForEach (0..<authorCount) {
                        Text(paperViewModel.authors[$0].name).font(.custom("some", size: 10)).lineLimit(1)
                    }
                    Text("+\((paperViewModel.authors.count) - authorCount) authors").font(.custom("some", size: 10)).lineLimit(1)
                }.padding(0).frame(maxWidth: .infinity, alignment: .center)
            } else {
                LazyVGrid(columns: columns, spacing: 3) {
                    ForEach(paperViewModel.authors, id: \.authorId) { author in
                        Text(author.name).font(.custom("some", size: 10)).lineLimit(1)
                    }
                }.padding(0).frame(maxWidth: .infinity, alignment: .center)
            }

            HStack(alignment: .center) {
                Text(paperViewModel.pubVenue ?? "").font(.caption).foregroundStyle(Color(white: 0.4)).multilineTextAlignment(.center)
            }.padding(0)
            
            HStack(alignment: .top) {
                Text(paperViewModel.pubDate ?? "").font(.caption).foregroundStyle(Color(white: 0.3))
                Text("|").foregroundStyle(Color(white: 0.7)).font(.caption)
                Text(paperViewModel.category).font(.caption).foregroundStyle(Color(white: 0.3))
            }.padding(0)
            
            var abs = paperViewModel.abstract ?? ""
            if let tldr = paperViewModel.tldr, !tldr.isEmpty {
                Text("TLDR: " + tldr).padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)).font(.custom("para-paper", size: 13)).multilineTextAlignment(.leading).lineLimit(6)
            } else {
                Text("TLDR: " + abs).padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)).font(.custom("para-paper", size: 13)).multilineTextAlignment(.leading).lineLimit(6)
            }
            HStack(alignment: .top) {
                Text(String(paperViewModel.numCitations) + " citations").foregroundStyle(Color(red: 0.9, green: 0.7, blue: 0.2)).bold().font(.title3)
            }.padding(EdgeInsets(top: 1, leading: 5, bottom: 5, trailing: 5))
            HStack(alignment: .bottom) {
                Button {
                    if let link = paperViewModel.pdfLink, let url = URL(string: link) {
                           UIApplication.shared.open(url)
                        }
                } label: {
                    Label(.init("View Paper"), systemImage: "arrow.up.right.bottomleft.rectangle.fill").font(.footnote)
                }.foregroundStyle(.brown).hoverEffect(.highlight).frame(maxWidth: .infinity, alignment: .leading).padding()
                
                let fp = favPapers.first { paper in
                    paper.paperId == paperViewModel.paperId
                }
                
                if let favPaper = fp {
                    Button {
                        print("removing \(favPaper)")
                        viewContext.delete(favPaper)
                        try? viewContext.save()
                    } label: {
                        Label(.init("Remove from favourites"), systemImage: "trash.fill").font(.footnote)
                    }.foregroundStyle(.red).frame(maxWidth: .infinity, alignment: .trailing).padding()
                } else {
                    Button {
                        print("adding \(paperViewModel.paperId)")
                        let favPaper = FavouritePaper(context: viewContext)
                        favPaper.paperId = paperViewModel.paperId
                        viewContext.insert(favPaper)
                        try? viewContext.save()
                    } label: {
                        Label(.init("Add to Favourites"), systemImage: "heart.fill").font(.footnote)
                    }.foregroundStyle(.red).frame(maxWidth: .infinity, alignment: .trailing).padding()
                }
                
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(white: 0.96)).hoverEffect(.lift)
    }
}
//
//#Preview {
//    PaperView(paperViewModel: .init(paperId: "12345", title: "abcd", abstract: "ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem ipsum", pubDate: "05-06-1997", pubVenue: "abdcf kdjfn ksjnfd lorem ipsum ak dfjna dfjna lorem ipsum ak dfjna dfjna lorem", category: "science", pdfLink: "", doi: "", corpusId: 0, tldr: nil))
//}
