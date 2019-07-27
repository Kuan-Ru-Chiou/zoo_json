//
//  KivaLoanTableViewCell.swift
//  KivaLoan
//
//  Created by 邱冠儒on 4/10/2016.

//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel:UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var locationLabel:UILabel! {
        didSet {
            locationLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var useLabel:UILabel! {
        didSet {
            useLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var amountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
