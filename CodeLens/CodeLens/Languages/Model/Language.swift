//
//  Language.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 25/07/26.
//
import Foundation

struct Language: Codable, Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var isAvailable: Bool
}
