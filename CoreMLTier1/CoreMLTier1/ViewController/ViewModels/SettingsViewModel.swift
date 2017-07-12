//
//  SettingsViewModel.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 11/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class SettingsViewModel: NSObject {
    
    var selection: ((DetectorType) -> Void)?
    
    private var selectedType: DetectorType
    private var detectors = DetectorType.allValues
    
    init(type: DetectorType) {
        selectedType = type
        super.init()
    }
}

extension SettingsViewModel: UITableViewDelegate, UITableViewDataSource {
    
    var selectedIndexPath: IndexPath {
        return IndexPath(row: detectors.index(where: { $0 == selectedType })!, section: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detectors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            SettingsCellView.reuseIdentifier) as! SettingsCellView
        
        let detector = detectors[indexPath.row]
        
        cell.load(viewModel: SettingsCellViewModel(title: detector.rawValue,
                                                   description: "",
                                                   accessoryType: detector == selectedType ?
                                                    .checkmark :
                                                    .none))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedType = detectors[indexPath.row]
        selection?(selectedType)
    }
}
