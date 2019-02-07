//
//  TabellViewController,swift
//  Meme.0.1
//
//  Created by Osiem Teo on 01/04/1440 AH.
//  Copyright © 1440 Asma. All rights reserved.
//

import UIKit

class TabellViewController: UITableViewController  {
    
    
    var memes : [Meme]!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
        
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tabelCell")
            
            else {
                fatalError("couldn't load cell for tabel view")
        }
        let meme = memes[indexPath.row]
        cell.textLabel?.text = meme.topText + meme.bottomText
        cell.imageView?.image = UIImage(ciImage: CIImage(image: meme.memedImage)!)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "detailid") as! DetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}

