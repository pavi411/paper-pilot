//
//  RecentPapersView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct RecentPapersView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favourites")
            VStack(alignment: .center) {
                PaperView()
                PaperView()
            }
        }
    }
}

#Preview {
    RecentPapersView()
}
