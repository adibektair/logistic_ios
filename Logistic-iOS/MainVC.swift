//
//  MainVC.swift
//  Logistic-iOS
//
//  Created by User on 6/18/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

private let reuseIdentifier = "Cell"

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products = [Product]()
    var selectedProduct: Product?
    override func viewDidLoad() {
//        navigationController?.navigationBar.prefersLargeTitles = true

        super.viewDidLoad()
        self.title = "Главная"
        self.getMyCards(completionHandler: { result in
            self.products = result
            self.collectionView.reloadData()
        })
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProduct = products[indexPath.row]
        self.performSegue(withIdentifier: "toProduct", sender: self)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.setView(product: products[indexPath.row])
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProduct"{
            let dest = segue.destination as! ProductViewController
            dest.product = selectedProduct
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width * 0.5) - 8
        return CGSize(width: width, height: width * 1.3)
        
    }
    

}

extension MainVC{
    
    func getMyCards (completionHandler: @escaping (_ cardy: [Product]) -> ()){
        Alamofire.request("http://87.255.197.72:8080/product/all", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Product]>) in
            if let result = response.result.value{
                completionHandler(result)
            }
        }
    }
    
}
