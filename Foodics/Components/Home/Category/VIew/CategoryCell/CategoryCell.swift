//
//  CategoryCell.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var CategoryName: UILabel!
    
    func configureCell(item: Category){
        
        CategoryName.text = item.name
    }
    
}
