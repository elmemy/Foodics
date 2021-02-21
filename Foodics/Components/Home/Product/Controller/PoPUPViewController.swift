//
//  ProdcutViewController.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 21/02/2021.
//

import UIKit
import Kingfisher

protocol ProdtocalDelegate {
    func productPicked (name : String , image : String , price : Double)
}


class PoPUPViewController: UIViewController {
    
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    
    
    var name:String?
    var image:String?
    var price:Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HandelData()
    }
    
    
    
    func HandelData(){
        Name.text = name
        Price.text = String(price ?? 0.0)
        
        let processor = DownsamplingImageProcessor(size: ImageView.frame.size)
            |> RoundCornerImageProcessor(cornerRadius: 10)
        
        ImageView.kf.indicatorType = .activity
        ImageView.kf.setImage(
            with: URL(string: image ?? ""),
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
    }
    
    @IBAction func DismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
