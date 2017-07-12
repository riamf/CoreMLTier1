//
//  SettingsCellView.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 12/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class SettingsCellView: UITableViewCell {
    
    static let reuseIdentifier = String(describing: SettingsCellView.self)
    
    private var modelTitle: UILabel!
    private var modelDecription: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        modelTitle = UILabel()
        contentView.addSubview(modelTitle)
        
        modelDecription = UILabel()
        modelDecription.textColor = UIColor.lightGray
        modelDecription.lineBreakMode = .byWordWrapping
        modelDecription.numberOfLines = 0
        contentView.addSubview(modelDecription)
        
        modelDecription.translatesAutoresizingMaskIntoConstraints = false
        modelTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: modelTitle.leadingAnchor,
                                             constant: -16.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: modelTitle.trailingAnchor,
                                              constant: 16.0).isActive = true
        contentView.topAnchor.constraint(equalTo: modelTitle.topAnchor,
                                         constant: -8.0).isActive = true
        modelTitle.bottomAnchor.constraint(equalTo: modelDecription.topAnchor,
                                           constant: -8.0).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo:
            modelDecription.leadingAnchor, constant: -16.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo:
            modelDecription.trailingAnchor, constant: 16.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo:
            modelDecription.bottomAnchor, constant: 8.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(viewModel: SettingsCellViewModel) {
        modelTitle.text = viewModel.title
        modelDecription.text = viewModel.description
        accessoryType = viewModel.accessoryType
    }
}

struct SettingsCellViewModel {
    let title: String
    let description: String
    let accessoryType: UITableViewCellAccessoryType
}
