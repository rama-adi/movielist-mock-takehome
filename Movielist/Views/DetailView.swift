//
//  DetailView.swift
//  Movielist
//
//  Created by Rama Adi Nugraha on 11/09/24.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            Image(movie.coverPhoto)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            
            VStack(spacing: 30) {
                Text("\(movie.genres.joined(separator: ", ")) · \(formatRuntime(movie.runTime))")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movie.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    HStack(spacing: 1) {
                        ForEach(0..<10) { index in
                            // display the amount of star
                            if index < Int(movie.rating) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    Text("\(movie.rating) / 10")
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                HStack {
                    VStack {
                        Text("Starring")
                            .font(.body)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(movie.starings, id: \.self) { starring in
                            Text(starring)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("Director(s)")
                            .font(.body)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(movie.directors, id: \.self) { director in
                            Text(director)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
        }
        .navigationTitle(movie.name)
    }
    
    func formatRuntime(_ runtime: Int) -> String {
        let hours = runtime / 3600
        let minutes = (runtime % 3600) / 60
        
        if hours == 0 {
            return "\(minutes) minute\(minutes != 1 ? "s" : "")"
        } else {
            return "\(hours) hour\(hours > 1 ? "s" : ""), \(minutes) minute\(minutes != 1 ? "s" : "")"
        }
    }
}

#Preview {
    DetailView(movie: Movie(
        name: "Test",
        directors: ["Test"],
        id: 1,
        youtubeLink: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        categories: [.trending],
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        starings: ["Test"],
        runTime: 9999,
        rating: 5, genres: ["Test"]
    ))
}
