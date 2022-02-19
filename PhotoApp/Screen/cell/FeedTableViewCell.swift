//
//  FeedTableViewCell.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 19.02.2022.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commandTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
