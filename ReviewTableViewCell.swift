//
//  ReviewTableViewCell.swift
//  morgansreview
//
//  Created by Morgan White on 2019-04-27.
//  Copyright © 2019 Morgan White. All rights reserved.
//

import UIKit

//this is the controller for my cell
class ReviewTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    //initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //configures the view of the state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
