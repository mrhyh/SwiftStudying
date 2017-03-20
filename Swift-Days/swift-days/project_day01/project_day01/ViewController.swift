//
//  ViewController.swift
//  project_day01
//
//  Created by xcl on 16/2/29.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var detailVC : DetailViewController? = nil
    var imageArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        let file = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! file.contentsOfDirectory(atPath: path)
        for itemObjcet:String in items {
            if itemObjcet.hasPrefix("nssl") {
                imageArray.append(itemObjcet)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexpath = self.tableView.indexPathForSelectedRow {
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.detailItem = imageArray[indexpath.row]
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imageArray.count;
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.imageArray[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

