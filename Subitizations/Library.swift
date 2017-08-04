//
//  Parachute.swift
//  Multiplication Workout by NumberShapes
//
//  Created by Andrew Fenner on 8/23/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


// View that falls in from the upper left hand corner.
class modalview: UIView
{
    
    let label = UILabel()
    let scene = UIImageView()
    
    
    
    var contentview: CGRect
    {
        return self.bounds
    }
    
    var dropped = false
    
    var startframe: CGRect!
    
    
    // Hides the modal
    func putback()
    {
        if let start = startframe
        {
            
            self.layer.shadowPath = UIBezierPath(rect: RectZero).cgPath
            
            
            UIView.animate(withDuration: 1, animations:
                {self.frame = start})
        }
        
        dropped = false
        
    }
    
    // Drop function takes a message to display and then adds it to a view that animates by sliding into the view.
    func drop(_ image: UIImage,messege: String)
    {
        
        dropped = true
        
        let superrect = superview!.frame
        let HelpHeight = superrect.height*0.8
        
        
        
        label.font = UIFont(name: "ChalkBoard SE", size: HelpHeight/15)
        label.textAlignment = .center
        label.text = messege
        
        
        scene.image = image
    
        
    
        // Starts at CGRectZero before animation
        let endsize = CGSize(width: 3/4*HelpHeight, height: HelpHeight)
        
        startframe = CGRect(x: -superrect.width/2, y: -HelpHeight, width: 0, height: 0)
        
        var labelframe: CGRect {
            
            let x = CGFloat(0)
            let y = CGFloat(0)
            let h = HelpHeight/4
            let w = HelpHeight*3/4
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        var sceneframe: CGRect
        {
            let x = CGFloat(0)
            let y = 1/4*HelpHeight
            let h = HelpHeight*3/4
            let w = HelpHeight*3/4
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        scene.frame = sceneframe
        label.frame = labelframe
        
        self.frame = startframe
        

        
        UIView.animate(withDuration: 1, animations:
            {
                self.frame.size = endsize
                self.center = self.superview!.center
                // Could this be in init?
           
        },
        completion: {finished in self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath})
        

        
        
    }
    
    
    func panhandler(_ sender: UIPanGestureRecognizer)
    {
        
        if sender.state == .changed
        {
            let translation = sender.translation(in: self)
            
            self.frame.origin.x = translation.x + self.frame.origin.x
            self.frame.origin.y = translation.y + self.frame.origin.y
            
            sender.setTranslation(CGPoint.zero, in: self)
        }
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        self.putback()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 10
        
      
        
      
        self.addSubview(scene)
        self.addSubview(label)
        
        // Setting up the view.
        let pan = UIPanGestureRecognizer()
        self.addGestureRecognizer(pan)
        pan.addTarget(self, action: #selector(self.panhandler(_:)))
        
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
    }
    
    
}

