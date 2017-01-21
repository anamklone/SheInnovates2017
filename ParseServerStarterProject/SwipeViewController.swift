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
    
    //@IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    var pageInfo : [[String]] = [
        ["1_Anjali.jpg", "Anjali woke up from her bed in Chennai, India. Today is Diwali, the festival of lights. \"Anjali, it's time to go to the temple!\" Anjali hears her mom say.", "Do you go to temple today?", "yes"],
        ["2_Anjali.jpg", "At the temple, you hear your mom praying for your good health, good grades, and successful and happy future. Your father is praying for your happiness and health as well. You then go home.", "Would you like to go to school today?", "yes"],
        ["3_Anjali.jpg", "Anjali got ready for school. As she's packing her backpack, she hears her mother yelling, \"ANJALI! REMEMBER TO PUT ON FAIR AND LOVELY! How are you going to find a husband if your skin is not light?\"", "Do you put on the skin bleaching cream?", "no"],
        ["4_Anjali.jpg", "Anjali goes to school and sees her friend Roja. \"Hey Anjali,\" Roja says. \"So, do you know what you want to do in college yet? I've decided to become a doctor.\" \"I thought you wanted to become an artist?\" Anjali says. \"Yeah, but my parents don't consider artists to be sucessful...\"", "Would you like to pursue a major in college that you don't like to please your parents?", "no"],
        ["5_Anjali.jpg", "\"Wow, so you're not going to be an engineer? Even though your parents want you to be one?\" Roja asks. \"No, I'm going to be a writer,\" says Anjali. \"And I'm going to tell them that today!\"", "Do you tell your parents about what you want to be?", "yes"],
        ["6_Anjali.jpg", "On your way home from school, you pass a vendor selling fireworks. You were saving some money to buy a new book, but the fireworks would be great for Diwali.", "Do you spend your money on fireworks?", "yes"],
        ["7_Anjali.jpg", "You go home, light the fireworks, and celebrate Diwali with family, neighbors, and friends. When the celebration is over, you go back home to rest with your parents.", "Do you tell your parents what you want to study in college?", "yes"],
        ["8_Anjali.jpg", "\"You want to be a writer and not an engineer? How do you expect to pay the bills? How do you expect to take care of us when we're old? How do you expect to get a good job in America?\" yells your mother.", "Do you still want to be a writer?", "yes"],
        ["9_Anjali.jpg", "\"Your father rides a bicycle to work so that we could spend the money for a motocycle on your engineering tuition instead! He has given up so much for you, and you are just throwing it away!\"", "Do you still want to be a writer?", "yes"],
        ["10_Anjali.jpg", "\"And I see that you haven't used Fair & Lovely! How do you expect to find a nice husband who will take care of you and provide money for your future family if you don't look like the best version of yourself?\"", "Do you want to put on the skin bleaching cream?", "no"],
        ["11_Anjali.jpg", "Your mother goes off into her room, asking herself what she has done to deserve a daughter like this. Your father look disappointed in you. You have never seen your father look this disappointed before.\"", "Do you apologize and promise to be an engineer and use the cream?", "no"]
        ]
    var count = 0
    
    var initialPosition = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialPosition = CGPoint(x: imageView.center.x, y: imageView.center.y)
        
        textLabel.text = pageInfo[0][1]
        
        questionLabel.text = pageInfo[0][2]
        
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
                print("no")
                if pageInfo[count][3] == "no" {
                    goToNext()
                }
            } else if imageView.center.x > self.view.bounds.width - 100 {
                print("yes")
                if pageInfo[count][3] == "yes" {
                    goToNext()
                }
            }
            
            imageView.center = CGPoint(x: initialPosition.x, y: initialPosition.y)
            rotation = CGAffineTransform(rotationAngle: 0)
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            imageView.transform = stretchAndRotation
        }
    }
    
    func goToNext() {
        count = count + 1
        
        if count < pageInfo.count - 1 {
        
            let currentImage = UIImage(named: pageInfo[count][0])
        
            imageView.image = currentImage
        
            textLabel.text = pageInfo[count][1]
        
            questionLabel.text = pageInfo[count][2]
        } else {
            //goToEnd()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
