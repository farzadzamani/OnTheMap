//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Farzad on 12/29/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var studentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.dataSource = self
        studentTableView.delegate = self
        // Do any additional setup after loading the view.
    }
     func refresh() {
       
        studentTableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Entity.shared.studentLocations.count)
        return Entity.shared.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! studentTableViewCell
        configureCell(cell: cell, forRowAt: indexPath)
        
        let firstname = Entity.shared.studentLocations[indexPath.row].firstName
        let lastname = Entity.shared.studentLocations[indexPath.row].lastName
        cell.studentURL = Entity.shared.studentLocations[indexPath.row].mediaURL
        cell.textLabel?.text = "\(firstname) \(lastname)"
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item in \(indexPath)")
        let cell = tableView.cellForRow(at: indexPath) as! studentTableViewCell
        goTo(url: cell.studentURL!)
        print(cell.studentURL)
    }
    

}
