//
//  DetailViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit

class BookMemoViewController: UIViewController {
    
    var contents: String = "빈 공간"
    
    @IBOutlet var bookMemoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(contents)"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("bookMemo"), object: nil, userInfo: ["memo": bookMemoTextView.text ?? ""])
    }
    
 
    
 
}

