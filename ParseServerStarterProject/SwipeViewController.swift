//
//  SwipeViewController.swift
//  SheInnovates2017-Swift
//
//  Created by ANASTASIA:D on 1/20/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(gesture)
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let imageView = gestureRecognizer.view!
        
        imageView.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = imageView.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 100)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        imageView.transform = stretchAndRotation
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if imageView.center.x < 100 {
                print("Not chosen")
            } else if imageView.center.x > self.view.bounds.width - 100 {
                print("Chosen")
            }
            imageView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            rotation = CGAffineTransform(rotationAngle: 1)
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            imageView.transform = stretchAndRotation
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
