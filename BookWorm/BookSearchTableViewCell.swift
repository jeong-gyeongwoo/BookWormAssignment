//
//  BookSearchTableViewCell.swift
//  BookWorm
//
//  Created by 정경우 on 2023/08/09.
//

import UIKit

class BookSearchTableViewCell: UITableViewCell {

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentsLabel.font = .systemFont(ofSize: 13)
        contentsLabel.numberOfLines = 0
        bookImageView.contentMode = .scaleAspectFit
    }


    
}
