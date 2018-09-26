//
//  HistoryCell.swift
//  SearchApp
//
//  Created by kimdaeman14 on 2018. 9. 27..
//  Copyright © 2018년 A3LCamel. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    static let reusableIdentifier = "HistoryCell"

    
    @IBOutlet weak var historyLabel: UILabel!
    @IBAction func deleteButton(_ sender: Any) {
        print("deleteButton")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
