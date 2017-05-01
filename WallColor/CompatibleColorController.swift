//
//  CompatibleColorController.swift
//  WallColor
//
//  Created by Israel Hammon on 4/21/17.
//  Copyright © 2017 Israel Hammon. All rights reserved.
//

import UIKit
class CompatibleColorController: UIViewController {
    var solidcolor: UIColor?
    var actualalpha: CGFloat?
    var hexvaluestring: String?
    var rgbvaluestring: String?
    var previmage: UIImage?
    var hue: Int?
    var saturation: Int?
    var value: Int?
    var actualhue: CGFloat?
    var actualsaturation: CGFloat?
    var actualvalue: CGFloat?
    var tempactualhue: CGFloat?
    var tempactualsaturation: CGFloat?
    var tempactualvalue: CGFloat?
    var actualcompatiblecolors : [String: Float] = [:]
    var compatiblecolors : [String: Int] = [:]
    @IBOutlet weak var SolidColor: UIImageView!
    @IBOutlet weak var HexValue: UILabel!
    @IBOutlet weak var RGBValue: UILabel!
    @IBOutlet weak var CompatibleImage1: UIImageView!
    @IBOutlet weak var CompatibleImage2: UIImageView!
    @IBOutlet weak var CompatibleImage3: UIImageView!
    @IBOutlet weak var CompatibleImage4: UIImageView!
    @IBOutlet weak var CompatibleImage5: UIImageView!
    @IBOutlet weak var CompatibleImage6: UIImageView!
    @IBAction func PreviousView(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "PassBack", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassBack"{
            let imagedisplay = segue.destination as! ImageDisplayViewController
            imagedisplay.image = previmage
        }
    }
    func colorchanger(block: Int) // Changes hue to get compatible colors
    {
        if (block == 1) {compatiblecolors["h1"] = compatiblecolors["h1"]! + 180} // Complimentary Color
        if (block == 2) {compatiblecolors["h2"] = compatiblecolors["h2"]! + 120} // Color triad
        if (block == 3) {compatiblecolors["h3"] = compatiblecolors["h3"]! - 120} // Color triad
        if (block == 4) {compatiblecolors["h4"] = compatiblecolors["h4"]! - 30} // Adjacent Color
        if (block == 5) {compatiblecolors["h5"] = compatiblecolors["h5"]! + 30} // Adjacent Color
        if (block == 6) {compatiblecolors["h6"] = compatiblecolors["h6"]! + 150} // Split Complementary}
    }
    func hsvtorgb(block: Int) // Converts HSV ro RGB
    {
        var r = Float(0)
        var g = Float(0)
        var b = Float(0)
        
        let h = Float(compatiblecolors["h" + String(block)]!) // Angle in degrees [0,360] or -1 as Undefined
        let s = Float(actualcompatiblecolors["s" + String(block)]!) // Percent [0,1]
        let v = Float(actualcompatiblecolors["v" + String(block)]!)// Percent [0,1]
        if (s == 0) {r = v; g = v; b = v}

        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60 // Sector
        let i = floor(Float(sector))
        print (i)
        let f = Float(sector) - i // Factorial part of h
                
        let p = Float(v) * (1 - Float(s))
        let q = Float(v) * (1 - (Float(s) * f))
        let t = Float(v) * (1 - (Float (s) * (1 - f)))
                
                switch(i) {
                case 0:
                    r = v
                    g = t
                    b = p
                case 1:
                    r = q
                    g = v
                    b = p
                case 2:
                    r = p
                    g = v
                    b = t
                case 3:
                    r = p
                    g = q
                    b = v
                case 4:
                    r = t
                    g = p
                    b = v
                default:
                    r = v
                    g = p
                    b = q
            }
        
        actualcompatiblecolors["r" + String(block)] = r // Saves uncalculated red value
        actualcompatiblecolors["g" + String(block)] = g // Saves uncalculated green value
        actualcompatiblecolors["b" + String(block)] = b // Saves uncalculated blue value
        actualcompatiblecolors["a" + String(block)] = Float(actualalpha!)
        compatiblecolors["r" + String(block)] = Int(r * 255)
        compatiblecolors["g" + String(block)] = Int(g * 255)
        compatiblecolors["b" + String(block)] = Int(b * 255)
        compatiblecolors["a" + String(block)] = Int(actualalpha!)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Holds RGB and HSV in full Int form
        compatiblecolors = ["r1": 0, "g1": 0, "b1": 0,"a1": 0, "h1": hue!, "s1": saturation!, "v1":value!,"r2": 0, "g2": 0, "b2": 0,"a2": 0, "h2": hue!, "s2": saturation!, "v2": value!,"r3": 0, "g3": 0, "b3": 0,"a3": 0, "h3": hue!, "s3": saturation!, "v3": value!,"r4": 0, "g4": 0, "b4": 0,"a4": 0, "h4": hue!, "s4": saturation!, "v4": value!,"r5": 0, "g5": 0, "b5": 0,"a5": 0, "h5": hue!, "s5": saturation!, "v5": value!,"r6": 0, "g6": 0, "b6": 0,"a6": 0, "h6": hue!, "s6": saturation!, "v6": value!]
        // Holds RGB and HSV in uncalculated Float form
        actualcompatiblecolors = ["r1": 0, "g1": 0, "b1": 0,"a1": 0, "h1": Float(actualhue!), "s1": Float(actualsaturation!), "v1": Float(actualvalue!),"r2": 0, "g2": 0, "b2": 0,"a2": 0, "h2": Float(actualhue!), "s2": Float(actualsaturation!), "v2": Float(actualvalue!),"r3": 0, "g3": 0, "b3": 0,"a3": 0, "h3": Float(actualhue!), "s3": Float(actualsaturation!), "v3": Float(actualvalue!),"r4": 0, "g4": 0, "b4": 0,"a4": 0, "h4": Float(actualhue!), "s4": Float(actualsaturation!), "v4": Float(actualvalue!),"r5": 0, "g5": 0, "b5": 0,"a5": 0, "h5": Float(actualhue!), "s5": Float(actualsaturation!), "v5": Float(actualvalue!),"r6": 0, "g6": 0, "b6": 0,"a6": 0, "h6": Float(actualhue!), "s6": Float(actualsaturation!), "v6": Float(actualvalue!)]
        colorchanger(block: 1) // Calculates compatible color
        hsvtorgb(block: 1) // Changes color to rgb
        colorchanger(block: 2)
        hsvtorgb(block: 2)
        colorchanger(block: 3)
        hsvtorgb(block: 3)
        colorchanger(block: 3)
        hsvtorgb(block: 4)
        colorchanger(block: 5)
        hsvtorgb(block: 5)
        colorchanger(block: 6)
        hsvtorgb(block: 6)
        HexValue.text = hexvaluestring
        RGBValue.text = rgbvaluestring
        SolidColor.backgroundColor = solidcolor
        CompatibleImage1.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r1"]!), green:CGFloat(actualcompatiblecolors["g1"]!), blue:CGFloat(actualcompatiblecolors["b1"]!), alpha:CGFloat(actualcompatiblecolors["a1"]!))
        CompatibleImage2.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r2"]!), green:CGFloat(actualcompatiblecolors["g2"]!), blue:CGFloat(actualcompatiblecolors["b2"]!), alpha:CGFloat(actualcompatiblecolors["a2"]!))
        CompatibleImage3.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r3"]!), green:CGFloat(actualcompatiblecolors["g3"]!), blue:CGFloat(actualcompatiblecolors["b3"]!), alpha:CGFloat(actualcompatiblecolors["a3"]!))
        CompatibleImage4.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r4"]!), green:CGFloat(actualcompatiblecolors["g4"]!), blue:CGFloat(actualcompatiblecolors["b4"]!), alpha:CGFloat(actualcompatiblecolors["a4"]!))
        CompatibleImage5.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r5"]!), green:CGFloat(actualcompatiblecolors["g5"]!), blue:CGFloat(actualcompatiblecolors["b5"]!), alpha:CGFloat(actualcompatiblecolors["a5"]!))
        CompatibleImage6.backgroundColor = UIColor(red:CGFloat(actualcompatiblecolors["r6"]!), green:CGFloat(actualcompatiblecolors["g6"]!), blue:CGFloat(actualcompatiblecolors["b6"]!), alpha:CGFloat(actualcompatiblecolors["a6"]!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
