//
//  ImageDisplayViewController.swift
//  WallColor
//
//  Created by Israel Hammon on 3/6/17.
//  Copyright © 2017 Israel Hammon. All rights reserved.
//

import UIKit

extension UIImage {
    
    subscript (x: Int, y: Int) -> UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
        
        let r = CGFloat((data?[pixelData])!) / 255.0
        let g = CGFloat((data?[pixelData + 1])!) / 255.0
        let b = CGFloat((data?[pixelData + 2])!) / 255.0
        let a = CGFloat((data?[pixelData + 3])!) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

class ImageDisplayViewController: UIViewController {

    var image: UIImage?
    var xcord: Int = 0
    var ycord: Int = 0
    
    
    @IBOutlet weak var imagecontrol: UIView!
    @IBOutlet weak var DisplayImage: UIImageView!
    
    @IBOutlet weak var SolidColor: UIImageView!
    @IBOutlet weak var HexValue: UILabel!
    @IBOutlet weak var RGBValue: UILabel!
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: DisplayImage)
            xcord = Int(position.x)
            ycord = Int(position.y)
            print(position.x)
            print(position.y)
            if let pixelcolor = image?[xcord, ycord] {
                var redcol: CGFloat = 0.0
                var greencol: CGFloat = 0.0
                var bluecol: CGFloat = 0.0
                var alphacol: CGFloat = 0.0
                pixelcolor.getRed(&redcol, green: &greencol, blue: &bluecol, alpha: &alphacol)
                
                // Do something with the color
                let redrgb = String((Int(Float(redcol) * 255)))
                let greenrgb = String((Int(Float(greencol) * 255)))
                let bluergb = String((Int(Float(bluecol) * 255)))
                RGBValue.text = redrgb + "," + greenrgb + "," + bluergb
                SolidColor.backgroundColor = UIColor(red: redcol, green: greencol, blue: bluecol, alpha: 1)
                print (Int(Float(alphacol)))
                print (pixelcolor)
                
                }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.resizeImage(UIImage()!, targetSize: CGSizeMake(200.0, 200.0))
        DisplayImage.image = image!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
