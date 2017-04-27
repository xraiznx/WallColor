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
    var actualcompatiblecolors : [String: CGFloat] = ["r1": 0, "g1": 0, "b1": 0,"a1": 0, "h1": 0, "s1": 0, "v1": 0,"r2": 0, "g2": 0, "b2": 0,"a2": 0, "h2": 0, "s2": 0, "v2": 0,"r3": 0, "g3": 0, "b3": 0,"a3": 0, "h3": 0, "s3": 0, "v3": 0,"r4": 0, "g4": 0, "b4": 0,"a4": 0, "h4": 0, "s4": 0, "v4": 0,"r5": 0, "g5": 0, "b5": 0,"a5": 0, "h5": 0, "s5": 0, "v5": 0,"r6": 0, "g6": 0, "b6": 0,"a6": 0, "h6": 0, "s6": 0, "v6": 0]
     var compatiblecolors : [String: Int] = ["r1": 0, "g1": 0, "b1": 0,"a1": 0, "h1": 0, "s1": 0, "v1": 0,"r2": 0, "g2": 0, "b2": 0,"a2": 0, "h2": 0, "s2": 0, "v2": 0,"r3": 0, "g3": 0, "b3": 0,"a3": 0, "h3": 0, "s3": 0, "v3": 0,"r4": 0, "g4": 0, "b4": 0,"a4": 0, "h4": 0, "s4": 0, "v4": 0,"r5": 0, "g5": 0, "b5": 0,"a5": 0, "h5": 0, "s5": 0, "v5": 0,"r6": 0, "g6": 0, "b6": 0,"a6": 0, "h6": 0, "s6": 0, "v6": 0]
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
    func colorchanger(block: Int){}
    func hsltorgb(block: Int){
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        let h = Float(hue! / 60)
        let s: CGFloat = actualsaturation!
        let v: CGFloat = actualvalue!
        let c = Float(v * s)
        let x = c * (1 - abs((h.truncatingRemainder(dividingBy: 2) - 1)))
        if (h == 0) { r = 0; g = 0; b = 0 }
        if ((0 <= h) && (h < 1)) { r = CGFloat(c); g = CGFloat(x); b = 0 }
        if ((1 <= h) && (h < 2)) { r = CGFloat(x); g = CGFloat(c); b = 0 }
        if ((2 <= h) && (h < 3)) { r = 0; g = CGFloat(c); b = CGFloat(x) }
        if ((3 <= h) && (h < 4)) { r = 0; g = CGFloat(x); b = CGFloat(c) }
        if ((4 <= h) && (h < 5)) { r = CGFloat(x); g = 0; b = CGFloat(c) }
        if ((5 <= h) && (h < 6)) { r = CGFloat(c); g = CGFloat(x); b = 0 }
        let m = CGFloat(v - CGFloat(c))
        r = r + m
        g = g + m
        b = b + m
        
        actualcompatiblecolors["r" + String(block)] = r
        actualcompatiblecolors["g" + String(block)] = g
        actualcompatiblecolors["b" + String(block)] = b
        actualcompatiblecolors["a" + String(block)] = actualalpha
        print(actualcompatiblecolors["r" + String(block)]! * 255)
        print(actualcompatiblecolors["g" + String(block)]! * 255)
        print(actualcompatiblecolors["b" + String(block)]! * 255)
        print(actualcompatiblecolors["a" + String(block)])
        print(actualcompatiblecolors["h" + String(block)]! * 60)
        print(actualcompatiblecolors["s" + String(block)]! * 100)
        print(actualcompatiblecolors["v" + String(block)]! * 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hsltorgb(block: 1)
        hsltorgb(block: 2)
        hsltorgb(block: 3)
        hsltorgb(block: 4)
        hsltorgb(block: 5)
        hsltorgb(block: 6)
        HexValue.text = hexvaluestring
        RGBValue.text = rgbvaluestring
        SolidColor.backgroundColor = solidcolor
        CompatibleImage1.backgroundColor = UIColor(red:actualcompatiblecolors["r1"]!, green:actualcompatiblecolors["g1"]!, blue:actualcompatiblecolors["b1"]!, alpha:actualcompatiblecolors["a1"]!)
        CompatibleImage2.backgroundColor = UIColor(red:actualcompatiblecolors["r2"]!, green:actualcompatiblecolors["g2"]!, blue:actualcompatiblecolors["b2"]!, alpha:actualcompatiblecolors["a2"]!)
        CompatibleImage3.backgroundColor = UIColor(red:actualcompatiblecolors["r3"]!, green:actualcompatiblecolors["g3"]!, blue:actualcompatiblecolors["b3"]!, alpha:actualcompatiblecolors["a3"]!)
        CompatibleImage4.backgroundColor = UIColor(red:actualcompatiblecolors["r4"]!, green:actualcompatiblecolors["g4"]!, blue:actualcompatiblecolors["b4"]!, alpha:actualcompatiblecolors["a4"]!)
        CompatibleImage5.backgroundColor = UIColor(red:actualcompatiblecolors["r5"]!, green:actualcompatiblecolors["g5"]!, blue:actualcompatiblecolors["b5"]!, alpha:actualcompatiblecolors["a5"]!)
        CompatibleImage6.backgroundColor = UIColor(red:actualcompatiblecolors["r6"]!, green:actualcompatiblecolors["g6"]!, blue:actualcompatiblecolors["b6"]!, alpha:actualcompatiblecolors["a6"]!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
