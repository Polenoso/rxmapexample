//
//  EventItemDetailView.swift
//  What To Do
//
//  Created by Aitor Pagán on 20/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class EventItemDetailView: UIView {

    let descriptionLabel = UILabel()
    
    var viewModel: EventItemDetailModelView? {
        didSet {
            descriptionLabel.text = viewModel?.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        
        addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    func updateUI(_ viewModel: EventItemDetailModelView) {
        self.viewModel = viewModel
    }
}
