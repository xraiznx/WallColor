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
    
    var tempImage: UIImage?
    
    @IBOutlet weak var ImageView: UIImageView! // Outlet for image to be displayed
    let picker = UIImagePickerController()
    
    @IBAction func NextScreen(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "DisplayImage", sender: nil)

    }
    @IBAction func TakePicture(_ sender: UIButton) { // When take picture button is pressed
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.cameraCaptureMode = .photo
    picker.modalPresentationStyle = .fullScreen
    present(picker,animated: true,completion: nil)
    }
    @IBAction func UseExisting(_ sender: UIButton) { // When use existing button is pressed
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        ImageView.image = tempImage
        dismiss(animated:true, completion: nil)
        
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
