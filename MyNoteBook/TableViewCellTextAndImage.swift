//
//  TableViewCellTextAndImage.swift
//  MyNoteBook
//
//  Created by Rasmus Knoth Nielsen on 13/03/2020.
//  Copyright © 2020 Rasmus Knoth Nielsen. All rights reserved.
//

import UIKit

class TableViewCellTextAndImage: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
