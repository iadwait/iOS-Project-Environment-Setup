//
//  LeftRightCell.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import UIKit

/// This Cell is used when we need Left and Right Label
class LeftRightCell: UITableViewCell {

    // MARK: - IBActions
    @IBOutlet weak var lblLeftLabel: UILabel!
    @IBOutlet weak var lblRightLabel: UILabel!
    
    // MARK: - Cell's Initialization Function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - User Defined Functions
    
    /// Function Call to setup Cell's UI
    func setupUI() {
        self.backgroundColor = ABUtils.shared.convertHexColor(forColor: ABThemeConstant.shared.White)
        self.selectionStyle = .none
    }
    
}
