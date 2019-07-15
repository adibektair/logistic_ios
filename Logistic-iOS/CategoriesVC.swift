//
//  CategoriesVC.swift
//  Logistic-iOS
//
//  Created by User on 6/19/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesVC: UITableViewController {

    var select = 0
    var name = ""
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Категории"
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never

        self.getCategories(completionHandler: {
            response in
            self.categories = response
            self.tableView.reloadData()
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.categoryName!.ru
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        select = categories[indexPath.row].productCategoryId!
        self.name = categories[indexPath.row].categoryName!.ru!
        self.performSegue(withIdentifier: "toSubcats", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubcats"{
            let dest = segue.destination as! SubcategoriesVC
            dest.categoryId = select
            dest.name = name
        }
    }
}
extension UIViewController{
    
    func getCategories (completionHandler: @escaping (_ cardy: [Category]) -> ()){
        Alamofire.request("http://87.255.197.72:8080/product/category/all", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Category]>) in
            if let result = response.result.value{
                completionHandler(result)
            }
        }
    }
    
    func getSubcategories (category_id: Int, completionHandler: @escaping (_ cardy: [Subcategory]) -> ()){
        Alamofire.request("http://87.255.197.72:8080/product/category/subcategory/category/\(category_id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Subcategory]>) in
            if let result = response.result.value{
                completionHandler(result)
            }
        }
    }
    
}
