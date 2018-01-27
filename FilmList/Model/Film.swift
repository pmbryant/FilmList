//
//  Film.swift
//  FilmList
//
//  Created by Peter Bryant on 1/21/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import Foundation

struct Film: Codable {
    let name: String
    let releaseYear: Int
    var forDisplay: String {
        return "\(name) (\(releaseYear))"
    }
}

enum Medium {
    case DVD, BLURAY, STREAMING, THEATER, OTHER
}

enum Source {
    case SELF, NETFLIX, AMAZON, WARNER_ARCHIVE_INSTANT, TCM, OTHER
}
