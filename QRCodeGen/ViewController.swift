//
//  ViewController.swift
//  QRCodeGen
//
//  Created by Gabriel Theodoropoulos on 27/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    
    var qrcodeImage: CIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func performButtonAction(_ sender: AnyObject) {
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            
            let data = textField.text!.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            
            textField.resignFirstResponder()
            
            btnAction.setTitle("Clear", for: UIControlState())
            
            displayQRCodeImage()
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            btnAction.setTitle("Generate", for: UIControlState())
        }
        
        textField.isEnabled = !textField.isEnabled
        slider.isHidden = !slider.isHidden
    }
    
    
    @IBAction func changeImageViewScale(_ sender: AnyObject) {
        imgQRCode.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    
    // MARK: Custom method implementation
    
    func displayQRCodeImage() {
        // let xymy=clmsimgQRCode.frame.size.width/qrcodeImage.extentize.width
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }
    
    
}

