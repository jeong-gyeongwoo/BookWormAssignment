//
//  LookAroundViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/08/02.
//

import UIKit

class MemoMovedViewController: UIViewController {
   
   
    @IBOutlet var movedMemoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movedMemoTextView.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(memo), name: NSNotification.Name("bookMemo"), object: nil)
    }


    @objc func memo(notification: NSNotification) {
        if let text = notification.userInfo?["memo"] as? String {
            print(text)
            movedMemoTextView.text = text
        }


    }
    

    
}


