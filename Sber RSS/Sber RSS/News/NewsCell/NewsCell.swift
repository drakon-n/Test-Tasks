//
//  NewsCell.swift
//  Sber RSS
//
//  Created by Влад on 09.10.2020.
//  Copyright © 2020 Влад. All rights reserved.
//

import UIKit

struct News {
 var title : String
 var newsImage : UIImage
 var description : String
}

class NewsCell: UITableViewCell {
    
    var news : News? {
    didSet {
    titleLabel.text = news?.title
    descriptionLabel.text = news?.description
    }
    }
    
    var titleLabel = UILabel();
    var descriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        //descriptionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true

        titleLabel.backgroundColor = UIColor.green
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(with model: NewsCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
