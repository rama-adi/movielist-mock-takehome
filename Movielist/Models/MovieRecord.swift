//
//  MovieRecord.swift
//  Movielist
//
//  Created by Rama Adi Nugraha on 11/09/24.
//


import Foundation

// MARK: - MovieRecord
struct MovieRecordResponse: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id, createdTime: String
    let fields: Movie
}

// MARK: - Fields
struct Movie: Codable, Identifiable {
    let name: String
    let directors: [String]
    let id: Int
    let youtubeLink: String
    let categories: [MovieCategory]
    let description: String
    let starings: [String]
    let runTime, rating: Int
    let genres: [String]
    
    var backgroundPhoto: String {
        return "\(id)_background"
    }
    
    var coverPhoto: String {
        return "\(id)"
    }
}

enum MovieCategory: String, Codable, CaseIterable {
    case popular = "Popular"
    case topRated = "Top Rated"
    case trending = "Trending"
}

