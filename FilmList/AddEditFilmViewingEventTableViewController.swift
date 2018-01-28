//
//  AddEditFilmViewingEventTableViewController.swift
//  FilmList
//
//  Created by Peter Bryant on 1/27/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import UIKit

class AddEditFilmViewingEventTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var filmViewingEvent: FilmViewingEvent?
    var mediumSourcePickerData: [[String]] = [[]]
    
    let dateFinishedDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    var isDateFinishedDatePickerVisible: Bool = false {
        didSet {
            dateFinishedDatePicker.isHidden = !isDateFinishedDatePickerVisible
        }
    }
    let mediumPickerIndex = 0
    let sourcePickerIndex = 1
    let mediumPickerCellIndexPath = IndexPath( row: 3, section: 3 )
    var isMediumSourcePickerVisible: Bool = false {
        didSet {
            mediumSourcePicker.isHidden = !isMediumSourcePickerVisible
        }
    }
    
    @IBOutlet weak var filmTitleField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var dateFinishedLabel: UILabel!
    @IBOutlet weak var dateFinishedDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfDaysStepper: UIStepper!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var numberOfSessionsStepper: UIStepper!
    @IBOutlet weak var numberOfSessionsLabel: UILabel!
    
    @IBOutlet weak var mediumSourceLabel: UILabel!
    @IBOutlet weak var mediumSourcePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filmViewingEvent = filmViewingEvent {
            filmTitleField.text = filmViewingEvent.film.name
            notesField.text = filmViewingEvent.notes
        }
        
        self.mediumSourcePicker.delegate = self
        self.mediumSourcePicker.dataSource = self
        
        mediumSourcePickerData = [ Medium.allValues, Source.allValues ]
        
        // Set latest date to allow use for 'dateFinishedWatching' date picker
        let maxDaysAheadAllowed = 7
        let midnightThisMorning = Calendar.current.startOfDay(for: Date())
        let aFewDaysFromNow = Calendar.current.date(byAdding: .day, value: maxDaysAheadAllowed, to: midnightThisMorning)
        dateFinishedDatePicker.maximumDate = aFewDaysFromNow
        
        updateDateView()
        updateDaysSessions()

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
    
    // MARK: - Convenience methods
    
    func updateDateView() {
        let df = DateFormatter()
        df.dateStyle = .medium
        dateFinishedLabel.text = df.string(from: dateFinishedDatePicker.date)
    }
    
    func updateDaysSessions() {
        numberOfDaysLabel.text = String( Int(numberOfDaysStepper.value) )
        numberOfSessionsLabel.text = String( Int(numberOfSessionsStepper.value) )
    }
    
    func updateMediumSource() {
        // TBD
    }
    
    // MARK: - Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch ( indexPath.section, indexPath.row ) {
        case ( dateFinishedDatePickerCellIndexPath.section, dateFinishedDatePickerCellIndexPath.row - 1 ):
            isDateFinishedDatePickerVisible = true
            isMediumSourcePickerVisible = false
        case ( mediumPickerCellIndexPath.section, mediumPickerCellIndexPath.row - 1 ):
            isDateFinishedDatePickerVisible = false
            isMediumSourcePickerVisible = true
        default:
            isDateFinishedDatePickerVisible = false
            isMediumSourcePickerVisible = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 44.0
        switch ( indexPath.section, indexPath.row ) {
        case ( dateFinishedDatePickerCellIndexPath.section, dateFinishedDatePickerCellIndexPath.row ):
            height = isDateFinishedDatePickerVisible ? 130.0 : 0.0
        case ( mediumPickerCellIndexPath.section, mediumPickerCellIndexPath.row ):
            height = isMediumSourcePickerVisible ? 70.0 : 0.0
        default:
            height = 44.0
        }
        return height
    }
    
    // MARK: - Actions

    @IBAction func numberOfDaysStepperValueChanged(_ sender: Any) {
        updateDaysSessions()
    }
    
    @IBAction func numberOfSessionsStepperValueChanged(_ sender: Any) {
        updateDaysSessions()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print( "Cancel button pressed - not implemented yet" )
    }
    
    @IBAction func dateFinishedPickerValueChanged(_ sender: Any) {
        updateDateView()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let filmName = filmTitleField.text ?? "No text in field yet"
        let notes = notesField.text ?? "No text in field yet"
        let dateFinished = dateFinishedDatePicker.date
        let nDays = numberOfDaysLabel.text
        let nSessions = numberOfSessionsLabel.text
        let mediumSource = mediumSourceLabel.text
        print( """
            doneButtonPressed: title in text field = \(filmName)
            notes field = \(notes).
            dateFinished=\(dateFinished)
            nDays=\(nDays ?? "nil"), nSessions=\(nSessions ?? "nil")
            mediumSource=\(mediumSource ?? "nil")
            """)
    }
    
    // MARK: - UIPickerViewDataSource protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mediumSourcePickerData[component].count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mediumSourcePickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let mediumRow = pickerView.selectedRow(inComponent: 0)
        let sourceRow = pickerView.selectedRow(inComponent: 1)
        let medium = mediumSourcePickerData[0][mediumRow]
        let source = mediumSourcePickerData[1][sourceRow]
        mediumSourceLabel.text = "\(medium) - \(source)"
    }
    

}
