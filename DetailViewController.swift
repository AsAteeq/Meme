//
//  DetailViewController.swift
//  Meme.0.1
//
//  Created by Osiem Teo on 01/04/1440 AH.
//  Copyright © 1440 Asma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var meme : Meme!
    
    @IBOutlet weak var img: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.label.text = self.villain.name
        self.tabBarController?.tabBar.isHidden = true
        self.img!.image = UIImage(ciImage: CIImage(image: meme.memedImage)!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
