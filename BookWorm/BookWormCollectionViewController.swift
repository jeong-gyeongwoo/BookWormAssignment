//
//  BookWormCollectionViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit
import RealmSwift
import Kingfisher

private let reuseIdentifier = "Cell"

class BookWormCollectionViewController: UICollectionViewController {
    var mvInfo = MovieInfo().movie
    var bookRealm: Results<BookTable>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "경우님의 책장"
        let nib = UINib(nibName: "BookWormCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookWormCollectionViewCell")
        setCollectionViewLayout()
        
        bookRealm = realm.objects(BookTable.self).sorted(byKeyPath: "title", ascending: true)
        //print(realm.configuration.fileURL)
        print(bookRealm)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(memo), name: NSNotification.Name("bookMemo"), object: nil)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("bookMemo"), object: nil)
//
//    }
//
    @objc func memo(notification: NSNotification) {
        if let text = notification.userInfo?["memo"] as? String {
            print(text)
            title = text
        }
    
    }
    
    
    func RandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookRealm.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWormCollectionViewCell", for: indexPath) as! BookWormCollectionViewCell
        
        let data = bookRealm[indexPath.row]
        
        //guard let url = URL(string: data.thumbnail) else { return UICollectionViewCell() }
        //cell.thumbnail.kf.setImage(with: url)
        cell.thumbnail.image = loadImageToDocument(fileName: "book_\(data._id).jpg")
        cell.titleAuthorPrice.text = "\(data.title) | \(data.authors) | \(data.price)"
        cell.contents.text = data.contents
        //cell.memoButton.tag = indexPath.row
        cell.memoButton.addTarget(self, action: #selector(memoButtonClicked), for: .touchUpInside)
        
        //        if MovieInfo().movie[indexPath.row].like == true {
        //            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        //        } else {
        //            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        //        }
        
        
        return cell
    }
    
    @objc
    func memoButtonClicked(_ sender: UIButton) {
        //mvInfo[sender.tag].like.toggle()
        //print(sender.tag)
        //collectionView.reloadData()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookMemoViewController") as! BookMemoViewController
        
        vc.contents = "메모 적기"

        navigationController?.pushViewController(vc, animated: true)

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
    
    @IBAction func lookAroundBarButtonItem(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MemoMovedViewController") as! MemoMovedViewController
        
        let nav = UINavigationController(rootViewController: vc)
        //nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
 
    }
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookSearchViewController") as! BookSearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        let data = bookRealm[indexPath.row]
        removeImageFromDocument(fileName: "book_\(data._id).jpg")
        try! realm.write {
            realm.delete(data)
        }
        
        collectionView.reloadData()
        
        
    }
    
}


// viewWillDisappear 논리적 오류?
//책 메모는 임시로 타이틀로 넘김
// MemoMovedViewController -> notification
