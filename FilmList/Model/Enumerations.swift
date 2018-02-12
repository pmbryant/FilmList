//
//  Enumerations.swift
//  FilmList
//
//  Created by Peter Bryant on 2/11/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import Foundation

enum Medium: String {
    case DVD = "DVD"
    case BLURAY = "Bluray"
    case STREAMING = "Online"
    case THEATER = "Theater"
    case OTHER = "Other"
    static let allValues = [ DVD, BLURAY, STREAMING, THEATER, OTHER ].map() { $0.rawValue }
}

enum Source: String {
    case SELF = "B&B"
    case NETFLIX = "Netflix"
    case AMAZON = "Amazon"
    case WARNER_ARCHIVE_INSTANT = "WAI"
    case TCM = "TCM"
    case OTHER = "Other"
    static let allValues = [ SELF, NETFLIX, AMAZON, WARNER_ARCHIVE_INSTANT, TCM, OTHER ].map() { $0.rawValue }
}
