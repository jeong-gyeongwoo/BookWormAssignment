//
//  RealmModel.swift
//  BookWorm
//
//  Created by 정경우 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
  
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var authors: String
    @Persisted var contents: String
    @Persisted var price: Int
    @Persisted var thumbnail: String

    convenience init(title: String, authors: String, contents: String, price: Int, thumbnail: String ) {
       
        self.init()
        
        self.title = title
        self.authors = authors
        self.contents = contents
        self.price = price
        self.thumbnail = thumbnail
    }
    
    
  
    

    
}

