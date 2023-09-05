//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit

class BookMemoViewController: UIViewController {
    
    var contents: String = "빈 공간"
    
    @IBOutlet var bookMemoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(contents)"
        
        
        
        

    }
    

    

}
