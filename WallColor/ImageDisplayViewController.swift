//
//  ImageDisplayViewController.swift
//  WallColor
//
//  Created by Israel Hammon on 3/6/17.
//  Copyright © 2017 Israel Hammon. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var DisplayImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayImage.image = image!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
}
