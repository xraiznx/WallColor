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

    var image: UIImage? // Main image variable
    var xcord: Int = 0 // X-Coordinate
    var ycord: Int = 0 // Y-Coordinate
    var rgbvaluestring: String? // String that holds rgb value
    var hexvaluestring: String? // String that holds hex value
    var redcol: CGFloat = 0.0 // Holds red value
    var greencol: CGFloat = 0.0 // Holds green value
    var bluecol: CGFloat = 0.0 // Holds blue value
    var alphacol: CGFloat = 0.0 // Holds alpha value
    var fredcol: Float = 0.0 // Holds red value * 255
    var fgreencol: Float = 0.0 // Holds green value * 255
    var fbluecol: Float = 0.0 // Holds blue value * 255
    var falphacol: Float = 0.0 // Holds alpha value
    var actualhue: Float? // Holds actual hue
    var actualsaturation: Float? // Holds actual saturation
    var actualvalue: Float? // Holds actual value
    var hue: Int? // Holds hue * 60
    var saturation: Int? // Holds saturation * 100
    var value: Int? // Holds value * 100
    
    @IBOutlet weak var DisplayImage: UIImageView! // Image view of main image
    @IBOutlet weak var SolidColor: UIImageView! // Image view of solid color
    @IBOutlet weak var HexValue: UILabel! // Label holds hexvalue
    @IBOutlet weak var RGBValue: UILabel! // Label holds rgbvalue
    
    @IBAction func NextScreen(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SolidColor", sender: nil)
    }
    
    // Function that starts when screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            var touchPoint = touch.location(in: self.DisplayImage) // Saves location of touch
            
            touchPoint.x = touchPoint.x *  (DisplayImage.image?.size.width)! / DisplayImage.frame.width // Finds x value proportionate to image and display size
            touchPoint.y = touchPoint.y *  (DisplayImage.image?.size.height)! / DisplayImage.frame.height // Finds y value proportionate to image and display size
            
            xcord = Int(touchPoint.x) // Sets X-Coordinate to int of x value
            ycord = Int(touchPoint.y) // Sets Y-Coordinate to int of y value
            
            if let pixelcolor = image?[xcord, ycord] {
                redcol = 0.0
                greencol = 0.0
                bluecol = 0.0
                alphacol = 0.0
                fredcol = 0.0
                fgreencol = 0.0
                fbluecol = 0.0
                falphacol = 0.0
                pixelcolor.getRed(&redcol, green: &greencol, blue: &bluecol, alpha: &alphacol)
                fredcol = Float(redcol)
                fgreencol = Float(greencol)
                fbluecol = Float(bluecol)
                falphacol = Float(alphacol)

                
                // Do something with the color
                let redrgb = String((Int(Float(redcol) * 255)))
                let greenrgb = String((Int(Float(greencol) * 255)))
                let bluergb = String((Int(Float(bluecol) * 255)))
                rgbvaluestring = redrgb + "," + greenrgb + "," + bluergb
                rgb2hsv()
                RGBValue.text = rgbvaluestring
                SolidColor.backgroundColor = UIColor(red: redcol, green: greencol, blue: bluecol, alpha: 1)
                hexvaluestring = String(format:"%02X", Int(redrgb)!) + String(format:"%02X", Int(greenrgb)!) + String(format:"%02X", Int(bluergb)!)
                HexValue.text = hexvaluestring
                
                }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Solid Color"{
            let controller = segue.destination as! CompatibleColorController
            controller.solidcolor = SolidColor.backgroundColor!
            controller.hexvaluestring = hexvaluestring
            controller.rgbvaluestring = rgbvaluestring
            controller.previmage = image
            controller.hue = hue!
            controller.saturation = saturation!
            controller.value = value!
            controller.actualhue = CGFloat(actualhue!)
            controller.actualsaturation = CGFloat(actualsaturation!)
            controller.actualvalue = CGFloat(actualvalue!)
            controller.actualalpha = alphacol
        }
    }
    
    
    func rgb2hsv(){
        let r = fredcol
        let g = fgreencol
        let b = fbluecol
        var h : Float?
        var s : Float?
        var v : Float?
        let rgbmax = max(r,g,b)
        let rgbmin = min(r,g,b)
        let temp = rgbmax - rgbmin
        v = rgbmax
        if (rgbmax == r) { h = ((g - b) / temp).truncatingRemainder(dividingBy: 6) }
        if (rgbmax == g) { h = ((b - r) / temp) + 2 }
        if (rgbmax == b) { h = ((r - g) / temp) + 4 }
        if (rgbmax == 0) { s = 0 }
        if (rgbmax != 0) { s = temp/rgbmax }
        
        if (h! < Float(0)) { hue = Int((h! * Float(60)) + Float(180))}
        else { hue = Int(h! * Float(60))}
            
        saturation = Int(s! * Float(100))
        value = Int(v! * Float(100))
        actualhue = h
        actualsaturation = s
        actualvalue = v
        print (hue, saturation, value)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.resizeImage(UIImage()!, targetSize: CGSizeMake(200.0, 200.0))
        DisplayImage.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
