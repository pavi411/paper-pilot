//
//  CategoryView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct CategoryView: View {
    let data: [CategoryViewModel] = [.init(title: "testing", paperCount: 3, imageUrl: "abc"), .init(title: "tesing", paperCount: 3, imageUrl: "abc"), .init(title: "teing", paperCount: 3, imageUrl: "abc")]
    let columns = [
            GridItem(.adaptive(minimum: 120))
        ]
    
    var body: some View {
        ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(data, id: \.self) { item in
                            VStack(alignment: .center) {
                                Text(item.title)
                                Image(uiImage: .init(resource: .init(name: "abc", bundle: .main)))
                                    .resizable()
                                    .frame(height: 128)
                            }
                           
                        }
                    }
                    .padding(.horizontal)
                }
        .frame(width: .infinity)
    }
}

#Preview {
    CategoryView()
}
