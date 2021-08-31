//
//  Goods.swift
//  test_shop
//
//  Created by Влад on 27.08.2021.
//

import Foundation
import UIKit


struct Product {
    var name:String
    var description:String
    var price:Float
    var image:UIImage
    var rate:Float
    
}

class Goods {
    var products = [Product]()
    init(){
        setup()
    }
    func setup(){
        let p1 = Product(name:"Продукт 1", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:220, image:UIImage(named: "p1")!, rate:8.9)
        let p2 = Product(name:"Продукт 2", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:205, image:UIImage(named: "p2")!, rate:8.2)
        let p3 = Product(name:"Продукт 3", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:270, image:UIImage(named: "p3")!, rate:6.3)
        let p4 = Product(name:"Продукт 4", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:123, image:UIImage(named: "p3")!, rate:4.3)
        let p5 = Product(name:"Продукт 5", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:56, image:UIImage(named: "p3")!, rate:9.3)
        let p6 = Product(name:"Продукт 6", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", price:670, image:UIImage(named: "p3")!, rate:6.8)
        self.products = [p1,p2,p3,p4,p5,p6]
    }
}
