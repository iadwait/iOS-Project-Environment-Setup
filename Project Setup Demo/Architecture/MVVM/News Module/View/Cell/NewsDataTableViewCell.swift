//
//  NewsDataTableViewCell.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 09/02/22.
//

import UIKit

class NewsDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        lblTitle.textColor = .darkGray
        lblDesc.textColor = .lightGray
    }
    
}
