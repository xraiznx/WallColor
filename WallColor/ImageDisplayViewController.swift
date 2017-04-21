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
    
    
    @IBOutlet weak var DisplayImage: UIImageView!
    
    @IBOutlet weak var SolidColor: UIImageView!
    @IBOutlet weak var HexValue: UILabel!
    @IBOutlet weak var RGBValue: UILabel!
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            var touchPoint = touch.location(in: self.DisplayImage)
            
            touchPoint.x = touchPoint.x *  (DisplayImage.image?.size.width)! / DisplayImage.frame.width
            touchPoint.y = touchPoint.y *  (DisplayImage.image?.size.height)! / DisplayImage.frame.height
            
            print("Touched point (\(touchPoint.x), \(touchPoint.y)")
            xcord = Int(touchPoint.x)
            ycord = Int(touchPoint.y)
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
                let hexValue = String(format:"%02X", Int(redrgb)!) + String(format:"%02X", Int(greenrgb)!) + String(format:"%02X", Int(bluergb)!)
                HexValue.text = hexValue
                
                }
        }
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
