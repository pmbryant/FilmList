//
//  FilmWatchList.swift
//  FilmList
//
//  Created by Peter Bryant on 1/21/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import Foundation

class FilmWatchList {
    let name: String
    var events: [FilmViewingEvent]
    var total: Int {
        return events.count
    }
    
    init( name: String ) {
        self.name = name
        self.events = []
    }
    
    func add(_ filmViewingEvent: FilmViewingEvent) {
        events.append(filmViewingEvent)
    }
    
}
