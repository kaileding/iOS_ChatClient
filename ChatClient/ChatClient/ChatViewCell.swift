//
//  ChatViewCell.swift
//  ChatClient
//
//  Created by hideki on 10/26/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
