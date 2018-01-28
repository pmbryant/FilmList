//
//  AddEditFilmViewingEventTableViewController.swift
//  FilmList
//
//  Created by Peter Bryant on 1/27/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import UIKit

class AddEditFilmViewingEventTableViewController: UITableViewController {

    var filmViewingEvent: FilmViewingEvent?
    
    @IBOutlet weak var filmName: UITextField!
    @IBOutlet weak var filmYear: UIView!
    @IBOutlet weak var dateFinishedViewing: UITextField!
    @IBOutlet weak var rewatchNumber: UITextField!
    @IBOutlet weak var nDays: UITextField!
    @IBOutlet weak var nSessions: UITextField!
    @IBOutlet weak var medium: UITextField!
    @IBOutlet weak var source: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filmViewingEvent = filmViewingEvent {
            filmName.text = filmViewingEvent.film.name
            filmYear.text = filmViewingEvent.film.releaseYear
            dateFinishedViewing.text = filmViewingEvent.viewingData?.dateForDisplay
            rewatchNumber.text = filmViewingEvent.viewingData?.rewatchNumber
            nDays.text = filmViewingEvent.viewingData?.numberOfDaysToComplete
            nSessions.text = filmViewingEvent.viewingData?.numberOfSessionsToComplete
            medium.text = filmViewingEvent.viewingData?.medium.rawValue
            source.text = filmViewingEvent.viewingData?.source.rawValue
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
