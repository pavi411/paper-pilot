//
//  DashboardView.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/24/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            Group {
                RecentPapersView().tabItem {
                    Label("Home", systemImage: "book.pages")
                }
                
                CategoryView().tabItem {
                    Label("Categories", systemImage: "rectangle.3.group.fill")
                }
            }.toolbarBackground(.gray, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    DashboardView()
}
