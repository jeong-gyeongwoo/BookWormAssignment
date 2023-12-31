//
//  BookSearchViewController.swift
//  BookWorm
//
//  Created by 정경우 on 2023/08/09.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import RealmSwift

struct Book {
    
    var authors: String
    var contents: String
    var thumbnail: String
    var title: String
    var price: Int
    
    var bookContents: String {
        return "제목:\(title) | 작가:\(authors) | 가격:\(price)"
    }
}

class BookSearchViewController: UIViewController {
    
    @IBOutlet var BookSearchTableView: UITableView!
    @IBOutlet var bookSearchBar: UISearchBar!
    
    var page = 1
    var isEnd = false
    var bookList: [Book] = []
   // var cell = BookSearchTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookSearchTableView.delegate = self
        BookSearchTableView.dataSource = self
        BookSearchTableView.prefetchDataSource = self
        BookSearchTableView.rowHeight = 200
        bookSearchBar.delegate = self
        
    }
    
    func callRequest(query: String, page: Int) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=20&page=\(page)"
        let header: HTTPHeaders = ["Authorization":"KakaoAK 75b4512ff0f50ed8d09239069a452cef"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                self.isEnd = json["meta"]["is_End"].boolValue
                
                
                for item in json["documents"].arrayValue {
                    let authors = item["authors"][0].stringValue
                    let contents = item["contents"].stringValue
                    let thumbnail = item["thumbnail"].stringValue
                    let title = item["title"].stringValue
                    let price = item["price"].intValue
                    
                    let data = Book(authors: authors, contents: contents, thumbnail: thumbnail, title: title, price: price)
                    
                    self.bookList.append(data)
                    self.BookSearchTableView.reloadData()
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func viewDismissButton(_ sender: UIButton) {
        navigationController?.dismiss(animated: true)
    }
    
    
    
    
    
    
    
    
}

extension BookSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked (_ searchBar: UISearchBar) {
        
        page = 1
        bookList.removeAll()
        
        guard let query = bookSearchBar.text else { return }
        callRequest(query: query, page: page)
    }
    
}

extension BookSearchViewController: UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 50 && !isEnd{
                page += 1
                callRequest(query: bookSearchBar.text!,page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //print("========,\(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "BookSearchTableViewCell") as! BookSearchTableViewCell
     
        cell.contentsLabel.text = bookList[indexPath.row].contents
        cell.titleLabel.text = bookList[indexPath.row].bookContents
        let url = URL(string: bookList[indexPath.row].thumbnail)
        cell.bookImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let bookRealm = BookTable(title: bookList[indexPath.row].title,
                                  authors: bookList[indexPath.row].authors,
                                  contents: bookList[indexPath.row].contents,
                                  price: bookList[indexPath.row].price,
                                  thumbnail: bookList[indexPath.row].thumbnail)
        print(bookRealm)
        try! realm.write {
            realm.add(bookRealm)
          //  print("추가 성공")
        }
        
        let value = URL(string: bookRealm.thumbnail )
        DispatchQueue.global().async {
            if let url = value, let data = try? Data(contentsOf: url ) {
                DispatchQueue.main.async {
                    self.saveImageToDocument(fileName: "book_\(bookRealm._id).jpg", image: UIImage(data: data)!)
                }
            }
        }
    }
    // main.async -> UI관련 속성이라?
    // global().async -> 네트워크 통신 관련 작업은(직접적인 통신이 아니여도) global().async?
    /*
     Synchronous URL loading of https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6167024%3Ftimestamp%3D20230725155343 should not occur on this application's main thread as it may lead to UI unresponsiveness. Please switch to an asynchronous networking API such as URLSession.
     */
}


