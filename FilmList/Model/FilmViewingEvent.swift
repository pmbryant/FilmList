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
    
    private init( film: Film, viewingData: ViewingData?) {
        self.film = film
        self.viewingData = viewingData
    }
    
    convenience init( film: Film ) {
        self.init( film: film, viewingData: nil )
    }
    
    convenience init( film: Film, with viewingData: ViewingData) {
        self.init(film: film, viewingData: viewingData)
    }
    
    convenience init( filmName: String, filmYear: Int, dateFinishedViewing: Date? ) {
        let aFilm = Film(name: filmName, releaseYear: filmYear)
        if let dateFinishedViewing = dateFinishedViewing {
            let someViewingData = ViewingData(dateFinishedViewing: dateFinishedViewing)
            self.init(film: aFilm, viewingData: someViewingData)
        } else {
            self.init(film: aFilm)
        }
    }
    
    convenience init( filmName: String, filmYear: Int, dateFinishedViewing dateFinishedViewingString: String ) {
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd"
        let dateFinishedViewing = formatter.date(from: dateFinishedViewingString)
        self.init( filmName: filmName, filmYear: filmYear, dateFinishedViewing: dateFinishedViewing )
    }
    
}


struct ViewingData {
    let dateFinishedViewing: Date
    //let numberOfSessionsToComplete: Int
    //let numberOfDaysToComplete: Int
    //let medium: Medium
    //let source: Source
    //let rewatch: Bool
    //let rewatchNumber: Int
    var forDisplay: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MMM-dd"
        let dateString = df.string(from: dateFinishedViewing)
        return "Finished viewing: \(dateString)"
    }
}
