//
//  GoodsViewController.swift
//  test_shop
//
//  Created by Влад on 27.08.2021.
//

import UIKit

class GoodsViewController: UIViewController {

    @IBOutlet weak var goodsCollectionView: UICollectionView!
    var goods:Goods = Goods()
    var numberInStack = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goodsCollectionView.register(UINib(nibName: "GoodCell", bundle: nil), forCellWithReuseIdentifier: "GoodCell")
        self.goodsCollectionView.dataSource = self
        self.goodsCollectionView.delegate = self
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            goods.products.sort{$0.name <= $1.name}
            goodsCollectionView.reloadData()
        }
        else if sender.selectedSegmentIndex == 1{
            goods.products.sort{$0.price <= $1.price}
            goodsCollectionView.reloadData()
        }
        else if sender.selectedSegmentIndex == 2{
            
            goods.products.sort{$0.rate >= $1.rate}
            goodsCollectionView.reloadData()
        }
    }
    
}
    

extension GoodsViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCell", for: indexPath) as! GoodCell
        let product = goods.products[indexPath.item]
        cell.setupCell(product: product)
        cell.layer.cornerRadius = 8.0
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2-20, height: UIScreen.main.bounds.width*0.65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 10)
    }
    


}
