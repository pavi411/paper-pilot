//
//  PaperView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct PaperView: View {
    
    var paperViewModel: PaperViewModel?
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Title").padding(EdgeInsets(top: 5, leading: 5, bottom: 1, trailing: 5))
            HStack(alignment: .top) {
                Text("Author")
                Text("Field")
            }.padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
            HStack(alignment: .top) {
                Text("Publication Venue")
                Text("Publication date")
            }.padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
            Text("Abstract").padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
            HStack(alignment: .top) {
                Text("citation count")
                Text("PDF link")
                Text("Fav")
            }.padding(EdgeInsets(top: 1, leading: 5, bottom: 5, trailing: 5))
        }.border(.gray, width: 1)
    }
}

#Preview {
    PaperView()
}
