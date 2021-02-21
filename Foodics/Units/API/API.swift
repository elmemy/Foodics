//
//  API.swift
//  Foodics
//
//  Created by Ahmed Elmemy on 20/02/2021.
//


import Foundation
import SwiftyJSON
import Alamofire
import SwiftEntryKit
import Localize_Swift


//import StatusAlert
class ATApi {
    

    static func fetchObjectGet<T : Decodable> (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (T ,String)->()){
        
        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        newHeader?["Authorization"] = Token.apiToken
        
        Alamofire.request(key, method: .get, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                do {
                    
                    let object = try JSONDecoder().decode(T.self, from: json["data"].rawData())
                    
                    completion(object , "")
                    
                }catch{
                    
                    print(error)
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    fetchObjectGet(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
}

extension UIViewController {
    func startAnimating  () {
        view.activityStartAnimating(activityColor: UIColor.BackGroundColor, backgroundColor: UIColor.black.withAlphaComponent(0.5))
    }
    
    func stopAnimating() {
        view.activityStopAnimating()
    }
    
    
    func presentRetryMessage (completionHandler : @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Network error!", message: "There is an error in network please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default){
            (action) in
            completionHandler()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
}
