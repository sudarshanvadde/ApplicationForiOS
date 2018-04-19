//
//  ViewController.swift
//  ApplicationForiOS
//
//  Created by Sundir Talari on 04/04/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var json = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        
        let url = URL(string: "http://jsonplaceholder.typicode.com/todos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data =  data else {return}
            
            do {
                
                 self.json = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
                //print(self.json)
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
                
                
            }catch{
                
                print("json error: \(error.localizedDescription)")
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = ((json[indexPath.row] as! [String: Any])["title"] as! String)
        return cell!
    }


}

