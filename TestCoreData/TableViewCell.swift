//
//  TableViewCell.swift
//  TestCoreData
//
//  Created by MacBook on 29/03/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String, author: String)
    {
        titleLbl.text = title
        authorLbl.text = author
    }

}
