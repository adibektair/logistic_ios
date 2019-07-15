//
//  SubcategoriesVC.swift
//  Logistic-iOS
//
//  Created by User on 6/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class SubcategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categoryId = Int()
    var subcategories = [Subcategory]()
    var name: String?
    override func viewDidLoad() {
        self.title = name
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.getSubcategories(category_id: categoryId, completionHandler: { cats in
            self.subcategories = cats
            self.tableView.reloadData()
        })
    }
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = subcategories[indexPath.row].subcategoryName!.ru!
        return cell
    }

}
