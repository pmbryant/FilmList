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
    var mediumPickerData: [String] = []
    var sourcePickerData: [String] = []
    
    let dateFinishedDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    var isDateFinishedDatePickerVisible: Bool = false {
        didSet {
            dateFinishedDatePicker.isHidden = !isDateFinishedDatePickerVisible
        }
    }
    let mediumPickerTag = 0
    let sourcePickerTag = 1
    let mediumPickerCellIndexPath = IndexPath( row: 3, section: 3 )
    let sourcePickerCellIndexPath = IndexPath( row: 5, section: 3 )
    var isMediumPickerVisible: Bool = false {
        didSet {
            mediumPicker.isHidden = !isMediumPickerVisible
        }
    }
    var isSourcePickerVisible: Bool = false {
        didSet {
            sourcePicker.isHidden = !isSourcePickerVisible
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
    
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var mediumPicker: UIPickerView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourcePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filmViewingEvent = filmViewingEvent {
            filmTitleField.text = filmViewingEvent.film.name
            notesField.text = filmViewingEvent.notes
        }
        
        mediumPickerData = Medium.allValues
        self.mediumPicker.delegate = self
        self.mediumPicker.dataSource = self
        
        sourcePickerData = Source.allValues
        self.sourcePicker.delegate = self
        self.mediumPicker.dataSource = self
        
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
            isMediumPickerVisible = false
            isSourcePickerVisible = false
        case ( mediumPickerCellIndexPath.section, mediumPickerCellIndexPath.row - 1 ):
            isDateFinishedDatePickerVisible = false
            isMediumPickerVisible = true
            isSourcePickerVisible = false
        case ( sourcePickerCellIndexPath.section, sourcePickerCellIndexPath.row - 1 ):
            isDateFinishedDatePickerVisible = false
            isMediumPickerVisible = false
            isSourcePickerVisible = true
        default:
            isDateFinishedDatePickerVisible = false
            isMediumPickerVisible = false
            isSourcePickerVisible = false
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
            height = isMediumPickerVisible ? 70.0 : 0.0
        case ( sourcePickerCellIndexPath.section, sourcePickerCellIndexPath.row ):
            height = isSourcePickerVisible ? 70.0 : 0.0
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
        let medium = mediumLabel.text
        let source = sourceLabel.text
        print( """
            doneButtonPressed: title in text field = \(filmName)
            notes field = \(notes).
            dateFinished=\(dateFinished)
            nDays=\(nDays ?? "nil"), nSessions=\(nSessions ?? "nil")
            medium=\(medium ?? "nil"), source=\(source ?? "nil")
            """)
    }
    
    // MARK: - UIPickerViewDataSource protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case mediumPickerTag, sourcePickerTag:
            return 1
        default:
            fatalError( "Unexpected picker view tag: \(pickerView.tag)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case mediumPickerTag:
            return mediumPickerData.count
        case sourcePickerTag:
            return sourcePickerData.count
        default:
            fatalError( "Unexpected picker view tag: \(pickerView.tag)")
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case mediumPickerTag:
            return mediumPickerData[row]
        case sourcePickerTag:
            return sourcePickerData[row]
        default:
            fatalError( "Unexpected picker view tag: \(pickerView.tag)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case mediumPickerTag:
            mediumLabel.text = mediumPickerData[row]
        case sourcePickerTag:
            sourceLabel.text = sourcePickerData[row]
        default:
            fatalError( "Unexpected picker view tag: \(pickerView.tag)")
        }
    }
    

}
