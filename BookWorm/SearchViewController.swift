//
//  ViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
    @objc
    func closeButtonClicked() {
        //push - pop, present- dismiss로 화면 열고 닫는법 맞춰주기
        dismiss(animated: true)
        
    }
    
}
