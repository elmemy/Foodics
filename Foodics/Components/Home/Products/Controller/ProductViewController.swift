//
//  ProductViewController.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import UIKit
import RealmSwift


protocol  productProtcol {
    func handleProductPress(name:String,price:Double,image:String)
}

class ProductViewController: UIViewController{
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var categories: [Any] = []
    let realm = try! Realm()
    var productModel  = [ProductModel]()
    
    var categoryName:String?
    
    
    var delegate : productProtcol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        SaveProduct()
        
    }
    
    
    
    
    func SaveProduct(){
        
        ATApi.fetchObjectGet(controller: self, key: URLs.products, parameters: [:], headers: nil) { (data : [ProductModel], msg) in
            
            self.productModel = data
            
            do {
                let realm = try Realm()
                print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
                
                
                let filtered = self.productModel.filter( {$0.category!.name == "\(self.categoryName ?? "")" })
                self.productModel = filtered
                
                
                try! realm.write{
                    
                    let allItem = realm.objects(ProductModel.self)
                    realm.delete(allItem)
                    
                    realm.add(self.productModel)
                    
                    
                    self.CollectionView.reloadData()
                    
                }
                
                
            }catch let error as NSError {
                print(error)
            }
        }
        
    }
    
    
    
    
    
}





extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.realm.objects(ProductModel.self).count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {return  UICollectionViewCell()}
        let Call = self.realm.objects(ProductModel.self)[indexPath.row]
        cell.configureCell(item: Call)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = self.realm.objects(ProductModel.self)[indexPath.row].name
        
        let image = self.realm.objects(ProductModel.self)[indexPath.row].image
        let price = self.realm.objects(ProductModel.self)[indexPath.row].price
        
        
        self.delegate?.handleProductPress(name: name , price: price , image: image ?? "" )
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColumns : CGFloat = 5
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 10
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        let width = cellDimension + 20
        return CGSize(width: cellDimension, height: width + 10)
    }
    
    
    
    
    
}

