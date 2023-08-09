//
//  LookAroundViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet var recentWatchedContents: UICollectionView!
    
    @IBOutlet var popularContents: UITableView!
    
    @IBOutlet var recentWatchedCell: UICollectionViewCell!
    
    @IBOutlet var popularContentsCell: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //recentWatchedContents.delegate = self
        //recentWatchedContents.dataSource = self
        //popularContents.delegate = self
        //popularContents.dataSource = self

        
        // recentWatchedContentsLayout()
        // popularContentsLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return UITableViewCell()
    }
    

    
}
