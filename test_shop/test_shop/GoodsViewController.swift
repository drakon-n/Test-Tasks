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
    

extension GoodsViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BasketStateUpdater, CustomCellUpdater{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCell", for: indexPath) as! GoodCell
        cell.delegate = self
        cell.index = indexPath.item
        cell.isOnBasket = goods.products[indexPath.item].isOnBasket
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cardView = CardView(frame: CGRect(x:1, y:95, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height*0.8))
        cardView.delegate = self
        cardView.delegateUpdater = self
        cardView.goodLabel.text = goods.products[indexPath.item].name
        cardView.priceLabel.text = String(goods.products[indexPath.item].price) + "₽"
        cardView.rateLabel.text = String(goods.products[indexPath.item].rate)
        cardView.descriptionLabel.text = goods.products[indexPath.item].description
        cardView.goodImage.image = goods.products[indexPath.item].image
        cardView.index = indexPath.item
        cardView.goods = goods.products
        if(goods.products[indexPath.item].isOnBasket==true){
            cardView.basketButton.setTitle("В корзине", for: .normal)
            cardView.basketButton.setTitleColor(.systemGreen, for: .normal)
            cardView.basketButton.isEnabled = false
        }else{
            cardView.basketButton.setTitle("В корзину", for: .normal)
            cardView.basketButton.setTitleColor(.black, for: .normal)
        }
        self.view.addSubview(cardView)
    }
    
    func updateBasketState(state:Bool, index: Int){
        goods.products[index].isOnBasket = state
    }
    
    func updateTableView(price: Float, isIncrement:Bool, queue:Int ) {
        
    }
    
    func justReload() {
        goodsCollectionView.reloadData()
    }


}
