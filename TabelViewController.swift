//
//  TableViewController.swift
//  Meme.0.1
//
//  Created by Osiem Teo on 29/03/1440 AH.
//  Copyright © 1440 Asma. All rights reserved.
//

import UIKit

class TabelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let memes : [Meme]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
