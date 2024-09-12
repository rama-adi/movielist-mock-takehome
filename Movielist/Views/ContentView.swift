//
//  ContentView.swift
//  Movielist
//
//  Created by Rama Adi Nugraha on 11/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView().tabItem {
                    Label("Movies", systemImage: "tv")
                }
                
                VStack{
                    Text("Stuff")
                }.tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }.navigationTitle("The MovieDB")
        }
    }
}

#Preview {
    ContentView()
}
