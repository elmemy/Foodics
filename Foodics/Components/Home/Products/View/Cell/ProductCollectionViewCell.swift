//
//  ProductCollectionViewCell.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 21/02/2021.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    
    func configureCell(item: ProductModel){
        
        name.text = item.name
        price.text = "\(item.price)"
                
        let processor = DownsamplingImageProcessor(size: ImageView.frame.size)
            |> RoundCornerImageProcessor(cornerRadius: 10)
        
        ImageView.kf.indicatorType = .activity
        ImageView.kf.setImage(
            with: URL(string: item.image ?? ""),
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        
    }
    
}
