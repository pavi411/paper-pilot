//
//  PaperDetailView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct PaperDetailView: View {
    let papers : [PaperViewModel] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("doi")
            Text("Corpus ID")
            Text("Title")
            Text("authors")
            Text("Publication date & venue")
            Text("Category")
            Text("Abstract")
            Text("pdf . citations")
            Text("Recommended papers")
            VStack(alignment: .leading) {
                ForEach(papers, id: \.self) { paper in
                    PaperView(paperViewModel: paper)
                }
            }
        }
    }
}

#Preview {
    PaperDetailView()
}
