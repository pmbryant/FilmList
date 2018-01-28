//
//  FilmWatchListTableViewController.swift
//  FilmList
//
//  Created by Peter Bryant on 1/21/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import UIKit

class FilmWatchListTableViewController: UITableViewController {

    var filmWatchList: FilmWatchList {
        let fwList = FilmWatchList(name: "Default list")
        
        var viewingData = ViewingData(dateFinishedAsString: "2017-12-31", medium: .DVD, source: .SELF, nDays: 1, rewatchNumber: 6)
        fwList.add( FilmViewingEvent(filmName: "Top Hat", filmYear: 1935, with: viewingData ))
        
        fwList.add( FilmViewingEvent(filmName: "Raiders of the Lost Ark", filmYear: 1981))
        
        viewingData = ViewingData(dateFinishedAsString: "2018-01-02", medium: .STREAMING, source: .TCM, nDays: 2, rewatchNumber: 1 )
        fwList.add( FilmViewingEvent(filmName: "The Man Who Came to Dinner", filmYear: 1942, with: viewingData ))
        return fwList
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmViewingEvent = filmWatchList.events[indexPath.row]
        print( "didSelectRowAt: \(indexPath.row) :: \(filmViewingEvent.forDisplay)")
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return filmWatchList.events.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmViewingEventCell", for: indexPath)
        let filmViewingEvent = filmWatchList.events[indexPath.row]
        print( "DEBUG: \(filmViewingEvent.viewingDataForDisplay)" )
        cell.textLabel?.text = filmViewingEvent.film.forDisplay
        cell.detailTextLabel?.text = filmViewingEvent.viewingDataForDisplay
        cell.showsReorderControl = true
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedEvent = filmWatchList.events.remove(at: indexPath.row)
            print( "Removing event: \(removedEvent.forDisplay)")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEvent = filmWatchList.events.remove(at: fromIndexPath.row)
        filmWatchList.events.insert(movedEvent, at: to.row)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
