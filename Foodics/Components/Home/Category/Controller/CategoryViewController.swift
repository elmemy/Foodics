//
//  CategoryViewController.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {
    
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var categories: [Any] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        let results = self.realm.objects(Category.self)
        print(results[0].name)
    }
    
    
    
    
    
}





extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.realm.objects(Category.self).count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return  UICollectionViewCell()}
        let Call = self.realm.objects(Category.self)[indexPath.row]
        cell.configureCell(item: Call)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = self.realm.objects(Category.self)[indexPath.row].name
        print(name)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        newViewController.categoryName = name
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColumns : CGFloat = 5
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 10
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        let width = cellDimension + 20
        return CGSize(width: cellDimension, height: width)
    }
    
    
    
    
    
}


extension CategoryViewController : productProtcol {
    func handleProductPress(name: String, price: Double, image: String) {
        // show pop view
        let storyboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "PoPUPViewController") as! PoPUPViewController
        newViewController.name = name
        newViewController.price = price
        newViewController.image = image
        present(newViewController, animated: true, completion: nil)
    }
    
    
}


