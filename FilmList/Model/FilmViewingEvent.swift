//
//  ViewingEvent.swift
//  FilmList
//
//  Created by Peter Bryant on 1/21/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import Foundation

class FilmViewingEvent {
    let film: Film
    var viewingData: ViewingData?
    var documented: Bool {
        return viewingData != nil
    }
    var viewingDateForSorting: String {
        if let dateFinished = viewingData?.dateFinishedViewing {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            return df.string(from: dateFinished)
        } else {
            return "1900"
        }
    }
    var viewingDataForDisplay: String {
        if let viewingData = viewingData {
            return viewingData.forDisplay
        } else {
            return "Undocumented"
        }
    }
    var forDisplay: String {
        return "Film: \(film.forDisplay), ViewingData: \(viewingDataForDisplay)"
    }
    
    private init( film: Film, with viewingData: ViewingData?) {
        self.film = film
        self.viewingData = viewingData
    }
    
    convenience init( film: Film ) {
        self.init( film: film, with: nil )
    }
    
    convenience init( filmName: String, filmYear: Int ) {
        let aFilm = Film( name: filmName, releaseYear: filmYear )
        self.init( film: aFilm )
    }
    
    convenience init( filmName: String, filmYear: Int, with viewingData: ViewingData? ) {
        let aFilm = Film(name: filmName, releaseYear: filmYear)
        if let viewingData = viewingData {
            self.init(film: aFilm, with: viewingData )
        } else {
            self.init(film: aFilm)
        }
    }
    
}


struct ViewingData {
    // Constant used to indicate that film has been watched some unknown number of times, but more than once.
    let REWATCH_INDETERMINATE_NUMBER: Int = 999
    
    let medium: Medium
    let source: Source
    let numberOfDaysToComplete: Int
    let dateFinishedViewing: Date?
    let numberOfSessionsToComplete: Int
    let rewatch: Bool
    let rewatchNumber: Int?
    
    var dateForDisplay: String {
        guard let dateFinishedViewing = dateFinishedViewing else { return "unparseable" }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MMM-dd"
        return df.string(from: dateFinishedViewing )
    }
    
    var rewatchForDisplay: String {
        if let rewatchNumber = rewatchNumber {
            return "#\(rewatchNumber)"
        } else {
            return rewatch ? "#N" : "#1"
        }
    }
    
    var sessionsForDisplay: String {
        if ( numberOfSessionsToComplete == numberOfDaysToComplete ) {
            return "\(numberOfDaysToComplete)d"
        } else {
            return "\(numberOfSessionsToComplete)s/\(numberOfDaysToComplete)d"
        }
    }
    
    var forDisplay: String {
        return "\(dateForDisplay), \(rewatchForDisplay), \(sessionsForDisplay), \(medium.rawValue)-\(source.rawValue)"
    }
    
    init( dateFinished: Date?, medium: Medium = .OTHER, source: Source = .OTHER, nDays: Int = 1, nSessions: Int = 0, rewatchNumber: Int = 1) {
        self.dateFinishedViewing = dateFinished
        self.medium = medium
        self.source = source
        self.numberOfDaysToComplete = nDays
        self.numberOfSessionsToComplete = nSessions <= 0 ? nDays : nSessions
        switch rewatchNumber {
        case REWATCH_INDETERMINATE_NUMBER:
            self.rewatch = true
            self.rewatchNumber = nil
        case 1:
            self.rewatch = false
            self.rewatchNumber = 1
        case 2...:
            self.rewatch = true
            self.rewatchNumber = rewatchNumber
        default:
            self.rewatch = false
            self.rewatchNumber = nil
        }
    }
    
    init( dateFinishedAsString: String, medium: Medium = .OTHER, source: Source = .OTHER, nDays: Int = 1, nSessions: Int = 0, rewatchNumber: Int = 1) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateFinished = df.date(from: dateFinishedAsString)
        self.init(dateFinished: dateFinished, medium: medium, source: source, nDays: nDays, nSessions: nSessions, rewatchNumber: rewatchNumber)
    }
}
