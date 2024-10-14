//
//  PaperListView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/28/24.
//

import SwiftUI

struct PaperListView: View {
    @ObservedObject var viewModel = PaperListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.papersByCategory, id: \.paperId) { paper in
                PaperView(paperViewModel: paper)
            }
        }
        .navigationTitle(Text("Papers"))
    }
}
//
//#Preview {
//    PaperListView()
//}
