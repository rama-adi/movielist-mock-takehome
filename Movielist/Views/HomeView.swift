//
//  HomeView.swift
//  Movielist
//
//  Created by Rama Adi Nugraha on 11/09/24.
//

import SwiftUI

struct HomeView: View {
    @State var movies: [Movie] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Now playing
                Text("Now Playing")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        
                        if movies.isEmpty {
                            ForEach(0..<10) { _ in
                                Rectangle()
                                    .frame(width: 200, height: 300)
                                    .foregroundStyle(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 5)
                            }
                        } else {
                            ForEach(movies) { movie in
                                NavigationLink {
                                    DetailView(movie: movie)
                                } label: {
                                    Image(movie.coverPhoto)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 300)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }.padding(.leading, 3)
                }
                
                // MARK: - Categories
                // We use MovieCategory.allCases to get all the cases of MovieCategory
                ForEach(MovieCategory.allCases, id: \.self) { category in
                    Text(category.rawValue)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            if movies.isEmpty {
                                ForEach(0..<10) { _ in
                                    Rectangle()
                                        .foregroundStyle(.gray)
                                        .frame(width: 280, height: 140)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .shadow(radius: 5)
                                        .padding(.leading, 3)
                                }
                            } else {
                                ForEach(filterByCategory(category: category)) { movie in
                                    NavigationLink {
                                        DetailView(movie: movie)
                                    } label: {
                                        CategoryCard(movie: movie)
                                    }.buttonStyle(PlainButtonStyle())
                                }.padding(.leading, 3)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            // MARK: - Spin up async task to fetch data
            do {
                let result = try await MovieAPI().listMovies()
                
                // Task is processed on different actor so we need to jump back to
                // the main actor since SwiftUI states are isolated to the main
                // actor.
                await MainActor.run {
                    movies = result.records.map { $0.fields }
                }
            } catch {
                print("Failed to fetch data")
            }
        }
    }
    
    // MARK: - Filter movies by category
    func filterByCategory(category: MovieCategory) -> [Movie] {
        return movies.filter { $0.categories.contains(category) }
    }
}

// MARK: - Category Card
struct CategoryCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(movie.backgroundPhoto)
                .resizable()
                .scaledToFill()
                .frame(width: 280, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 5)
                .padding(.leading, -1)
            
            Text(movie.name)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300, height: 50, alignment: .topLeading)
                .padding(.top, 5)
        }
        .frame(width: 300, height: 195)
    }
}

#Preview {
    ContentView()
}
