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
    
    convenience init( filmName: String, filmYear: Int, dateFinishedViewing: Date ) {
        let aFilm = Film(name: filmName, releaseYear: filmYear)
        let someViewingData = ViewingData(dateFinishedViewing: dateFinishedViewing)
        self.init(film: aFilm, viewingData: someViewingData)
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
}
