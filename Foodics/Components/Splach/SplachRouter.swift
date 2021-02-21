//
//  SplachRouter.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import UIKit

class SplachRouter {

    static func CategoryViewController(viewController:UIViewController){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        let nav = UINavigationController(rootViewController: newViewController)
//        nav.navigationBar.isHidden = true
        viewController.view.window?.rootViewController = nav
        
    }
 
    
}
