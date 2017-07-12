//
//  SettingsViewController.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 11/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let table = UITableView()
    private let button = UIButton()
    
    private let viewModel: SettingsViewModel
    
    init(selected: DetectorType, changeHandler: @escaping ((DetectorType) -> Void)) {
        
        viewModel = SettingsViewModel(type: selected)
        
        super.init(nibName: nil, bundle: nil)
        viewModel.selection = { [weak self] detectorType in
            self?.dismiss(animated: true, completion: nil)
            changeHandler(detectorType)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented 😜")
    }
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        
        view.addSubview(table, expand: true)
        
        table.register(SettingsCellView.self,
                       forCellReuseIdentifier: SettingsCellView.reuseIdentifier)
        table.delegate = viewModel
        table.dataSource = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
