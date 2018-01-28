//
//  MediumPickerView.swift
//  FilmList
//
//  Created by Peter Bryant on 1/28/18.
//  Copyright © 2018 pmb. All rights reserved.
//

import UIKit

class ArrayPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var values: [String]?
    weak var label: UILabel?
    
    // MARK: - UIPickerViewDataSource protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let values = values else { return 0 }
        return values.count
    }
    
    // MARK: - Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let values = values else { return nil }
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let label = label, let values = values else { return }
        label.text = values[row]
    }

}
