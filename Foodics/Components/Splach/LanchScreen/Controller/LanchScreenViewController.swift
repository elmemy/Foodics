//
//  LanchScreenViewController.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//

import UIKit
import RealmSwift

class LanchScreenViewController: UIViewController {
    
    
    var categoryModel = [Category]()
    let query = DispatchQueue(label: "saveDataRealm",attributes: .concurrent)
    let group = DispatchGroup()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        CateoryScreen()
    }
    
    
    func getData(){
        
        let realm = try! Realm()
        let saveData = realm.objects(Category.self)
        if saveData.count == 0{
            SaveCategoryData()
        }
    }
    
    
    
    //Save category at Realm
    func SaveCategoryData(){
        
        group.enter()
        
        ATApi.fetchObjectGet(controller: self, key: URLs.categories, parameters: [:], headers: nil) { (data : [Category], msg) in
            
            self.categoryModel = data
            
            do {
                let realm = try Realm()
                print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
                
                
                let saveData = realm.objects(Category.self)
                if saveData.count == 0{
                    try! realm.write{
                        realm.add(self.categoryModel)
                    }
                }
                
            }catch let error as NSError {
                print(error)
            }
            
            self.group.leave()
        }
        
    }
    
    
    
    
    //GotTOCateoryScreen
    func CateoryScreen(){
        group.notify(queue: query){
            DispatchQueue.main.async{
                SplachRouter.CategoryViewController(viewController: self)
            }
        }
    }
    
}
