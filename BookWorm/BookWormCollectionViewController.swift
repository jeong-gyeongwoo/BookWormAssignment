//
//  BookWormCollectionViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookWormCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "경우님의 책장"
        let nib = UINib(nibName: "BookWormCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookWormCollectionViewCell")
        setCollectionViewLayout()
        
    }
    func RandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWormCollectionViewCell", for: indexPath) as! BookWormCollectionViewCell
        
        cell.backgroundColor = RandomColor()

        cell.contentsImage.image = UIImage(named: MovieInfo().movie[indexPath.row].title)
        cell.contentsTitle.text = MovieInfo().movie[indexPath.row].title
        cell.contentsDate.text = MovieInfo().movie[indexPath.row].releaseDate
        
        return cell
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)

        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let sb = UIStoryboard(name: "Main", bundle: nil)
         let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
  
        vc.contents = MovieInfo().movie[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
