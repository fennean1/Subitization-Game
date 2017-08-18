//
//  GridItem.swift
//  Subitizations
//
//  Created by Andrew Fenner on 8/17/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit




class griditem: UIImageView
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        self.image = counterimage
        
    }
    
    
    func panhandle(_ sender: UIPanGestureRecognizer)
    {
        
        
        let translation = sender.translation(in: sender.view)
        
        if let view = sender.view
        {
            
            view.center = CGPoint(x: (view.center.x + translation.x),
                                  y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: sender.view)
        }
        
    }
    
    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panhandle))
        pan.cancelsTouchesInView = false
        self.frame = frame
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
        self.image = counterimage
    }
    
    
}
