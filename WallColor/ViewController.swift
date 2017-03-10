//
//  ViewController.swift
//  WallColor
//
//  Created by Israel Hammon on 2/24/17.
//  Copyright © 2017 Israel Hammon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var tempImage:UIImage?
    
    @IBOutlet weak var ImageView: UIImageView!
    let picker = UIImagePickerController()
    
    @IBAction func TakePicture(_ sender: UIButton) {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.cameraCaptureMode = .photo
    picker.modalPresentationStyle = .fullScreen
    present(picker,animated: true,completion: nil)
    }
    @IBAction func UseExisting(_ sender: UIButton) {
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            dismiss(animated:true, completion: nil)
        performSegue(withIdentifier: "DisplayImage", sender: self)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DisplayImage"{
        let controller = segue.destination as! ImageDisplayViewController
            controller.image = tempImage!
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    picker.delegate = self
    }
    }
