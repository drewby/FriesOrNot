//
//  ViewController.swift
//  FriesOrNot
//
//  Created by Drew Robbins on 2017/07/30.
//  Copyright © 2017 Drew Robbins. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var service = CustomVisionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resultLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected an image, but was provided \(info)")
        }
        
        photoImageView.image = selectedImage
       
	resultLabel.text = "" 
        self.activityIndicator.startAnimating()
        
        dismiss(animated: true, completion: nil)
        
        let imageData = UIImageJPEGRepresentation(selectedImage, 0.8)!
        service.predict(image: imageData, completion: { (result: CustomVisionResult?, error: Error?) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.resultLabel.text = error.localizedDescription
                } else if let result = result {
                    let prediction = result.Predictions[0]
                    let probabilityLabel = String(format: "%.1f", prediction.Probability * 100)
                    self.resultLabel.text = "\(probabilityLabel)% sure this is \(prediction.Tag)"
                }
            }
            
        })
    }
    
}

