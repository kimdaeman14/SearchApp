//
//  SearchResultCell.swift
//  SearchApp
//
//  Created by kimdaeman14 on 2018. 9. 27..
//  Copyright © 2018년 A3LCamel. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    static let reusableIdentifier = "SearchResultCell"

    @IBOutlet weak var searchResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
