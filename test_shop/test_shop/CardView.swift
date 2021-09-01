//
//  CardView.swift
//  test_shop
//
//  Created by Влад on 01.09.2021.
//

import UIKit
import CoreData
class CardView: UIView {
    
    var xButton:UIButton = UIButton()
    var goodLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var goodImage: UIImageView = UIImageView()
    var rateLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var basketButton: UIButton = UIButton()
    var index:Int = 0
    var goods:[Product] = []
    weak var delegate: BasketStateUpdater?
    weak var delegateUpdater: CustomCellUpdater?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupViews(){
        self.xButton = UIButton(frame: CGRect(x: self.bounds.width-50, y: 5, width: 50, height: 50))
        self.goodLabel = UILabel(frame: CGRect(x: 0, y: self.bounds.height*0.45, width: self.bounds.width*0.8, height: 50))
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: self.bounds.height*0.55, width: self.bounds.width*0.8, height: self.bounds.height*0.25))
        self.goodImage = UIImageView(frame: CGRect(x: 10, y:60, width: self.bounds.width-20, height: self.bounds.height*0.35))
        self.priceLabel = UILabel(frame: CGRect(x: self.bounds.width*0.1, y: self.bounds.height*0.5, width: self.bounds.width*0.25, height: 50))
        self.rateLabel = UILabel(frame: CGRect(x: self.bounds.width*0.7, y: self.bounds.height*0.5, width: self.bounds.width*0.2, height: 50))
        self.basketButton = UIButton(frame: CGRect(x: 10, y: self.bounds.height*0.85, width: self.bounds.width*0.35, height: 50))
        
        basketButton.center.x = self.center.x
        basketButton.backgroundColor = .systemGray6
        basketButton.setTitle("В корзину", for: .normal)
        basketButton.setTitleColor(.systemBlue, for: .normal)
        basketButton.addTarget(self, action:#selector(takeOnBasket), for: UIControl.Event.touchUpInside)
        
        rateLabel.textAlignment = NSTextAlignment.right
        rateLabel.font = UIFont.boldSystemFont(ofSize: 25)
        rateLabel.textColor = .systemRed
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.center.x = self.center.x
        
        goodLabel.center.x = self.center.x
        goodLabel.font = UIFont(name: goodLabel.font.fontName, size: 25)
        goodLabel.textAlignment = NSTextAlignment.center
        
        xButton.setTitle("X", for: .normal)
        xButton.backgroundColor = .black
        xButton.addTarget(self, action:#selector(closeCard), for: UIControl.Event.touchUpInside)
        
        self.addSubview(goodLabel)
        self.addSubview(xButton)
        self.addSubview(descriptionLabel)
        self.addSubview(goodImage)
        self.addSubview(priceLabel)
        self.addSubview(rateLabel)
        self.addSubview(basketButton)
    }
    
    func setupGestures(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        self.addGestureRecognizer(leftSwipe)
        self.addGestureRecognizer(rightSwipe)
    }
    
    @objc func closeCard(sender: UIButton){
        sender.superview?.removeFromSuperview()
        delegateUpdater?.justReload()
    }
    
    @objc func takeOnBasket(sender: UIButton){
        self.basketButton.setTitle("В корзине", for: .normal)
        self.basketButton.setTitleColor(.systemGreen, for: .normal)
        self.basketButton.isEnabled = false
        delegate?.updateBasketState(state: true, index:self.index)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Good", in: context)
        let newGood = NSManagedObject(entity: entity!, insertInto: context)
        newGood.setValue(self.goodLabel.text, forKey: "name")
        newGood.setValue(self.rateLabel.text, forKey: "rate")
        newGood.setValue(self.descriptionLabel.text, forKey: "decription")
        newGood.setValue(self.priceLabel.text, forKey: "price")
        newGood.setValue(1, forKey: "isOnBasket")
        newGood.setValue(1, forKey: "num")
        let imageData = goodImage.image?.pngData()
        newGood.setValue(imageData, forKey: "image")
        do{
            try context.save()
            basketData.append(newGood)
        } catch let error as NSError {
            print("Failed to save \(error)")
        }
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .left{
            if index<goods.count-1{
            index = index + 1
            }
            else{
            index = 0
            }
            setupCard(card: goods[index])
        }

        if sender.direction == .right{
            if (index > 0){
                index = index - 1
            }
            else{
                index = goods.count-1
            }
            setupCard(card: goods[index])
        }
    }
    
    
    func setupCard(card: Product){
        self.goodLabel.text = card.name
        self.descriptionLabel.text = card.description
        self.goodImage.image = card.image
        self.priceLabel.text = String(card.price) + "₽"
        self.rateLabel.text = String(card.rate)
        if(card.isOnBasket==true){
            self.basketButton.setTitle("В корзине", for: .normal)
            self.basketButton.setTitleColor(.systemGreen, for: .normal)
            self.basketButton.isEnabled = false
        }else{
            self.basketButton.setTitle("В корзину", for: .normal)
            self.basketButton.setTitleColor(.black, for: .normal)
        }
    }
    
}
