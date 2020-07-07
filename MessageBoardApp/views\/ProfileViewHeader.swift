//
//  ProfileViewHeader.swift
//  MessageBoardApp
//
//  Created by curtis scott on 07/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation
import UIKit
class ProfileViewHeader: UITableViewHeaderFooterView {
    let mainTitle = UILabel()
    let commentTitle = UILabel()
   
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        commentTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(mainTitle)
        self.contentView.addSubview(commentTitle)
      
         NSLayoutConstraint.activate([
            mainTitle.heightAnchor.constraint(equalToConstant: 30) ,
            mainTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 0),

            mainTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commentTitle.heightAnchor.constraint(equalToConstant: 30),
   
            commentTitle.trailingAnchor.constraint(equalTo:
                    contentView.layoutMarginsGuide.trailingAnchor),
            commentTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
            
        ])
    }
}
