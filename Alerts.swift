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
class helpview: UIView
{
    
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
            
            UIView.animate(withDuration: 1, animations:
                {self.frame = start})
        }
        
        dropped = false
        
    }
    
    // Drop function takes a message to display and then adds it to a view that animates by sliding into the view.
    func drop(_ image: UIImage)
    {
        
        dropped = true
        
        let superrect = superview!.frame
        
        let scene = UIImageView()
        
        scene.image = image
        
        self.addSubview(scene)
        
        
        let HelpHeight = superrect.height*0.8
        
        // Starts at CGRectZero before animatio
        let endsize = CGSize(width: HelpHeight*1.25, height: HelpHeight)
        
        startframe = CGRect(x: -superrect.width/2, y: -HelpHeight, width: HelpHeight*1.25, height: HelpHeight)
        
        var sceneframe: CGRect
        {
            let x = CGFloat(0)
            let y = CGFloat(0)
            let h = HelpHeight
            let w = h*1.25
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        scene.frame = sceneframe
        
        self.frame = startframe
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        
        UIView.animate(withDuration: 1, animations:
            {
                self.frame.size = endsize
                self.center = self.superview!.center
        })
        
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

