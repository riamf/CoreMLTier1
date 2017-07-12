//
//  UIView+Extensions.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 11/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

extension UIView {
    func addSubview(_ view: UIView, expand: Bool = false) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
