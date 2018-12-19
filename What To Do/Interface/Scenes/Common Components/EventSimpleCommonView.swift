//
//  EventSimpleCommonView.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class EventSimpleCommonView: UIView {

    private var locationLabel: UILabel = UILabel()
    private var emojiLabel: UILabel = UILabel()
    private var dateLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        emojiLabel.numberOfLines = 1
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        emojiLabel.textAlignment = .center
        
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = UIColor.blue
        dateLabel.textAlignment = .right
        
        addSubview(locationLabel)
        addSubview(emojiLabel)
        addSubview(dateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        locationLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        emojiLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8).isActive = true
        emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emojiLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public func updateUI(_ eventData: EventViewModel) {
        locationLabel.text = eventData.place
        emojiLabel.text = eventData.emoji
        dateLabel.text = eventData.startDate
    }

}
