//
//  Styles.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/14/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func editstyle(_ container: CGRect)
    {
        
        let w = container.width/12
        let h = 2/3*w
        let x = container.width/2 - container.width*3/7
        let y = container.width/18 + 1/4*container.height - h
        
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.setTitle("Edit", for: UIControlState())
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.titleLabel?.font = UIFont(name: chalkboardfont, size: self.frame.height/2)
        self.bringSubview(toFront: self.titleLabel!)
        self.titleLabel?.textColor = UIColor.white
        self.backgroundColor = UIColor.gray
        
    }
    
    
    
}


// Extensions to CGRect take the container and style it according to the object it's being assigned to. Ex: foo.frame.StyleFoo styles the frame of foo.

extension CGRect {
    
    
    mutating func styleScoreLabel(container: CGRect)
    {
        
        let h = container.height/7
        let w = 0.8*container.width
        
        let y = h
        let x = container.width/2 - w/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
    
    }
    
    // Styles a timer label to be displayed in the upper right of the screen.
    mutating func styleTimerLabel(container: CGRect) {
        
        
        let w = container.width/20
        let h = w
        
        let x = container.width - 1.5*w
        let y = 0.5*w
        
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    mutating func styleCenterButton(container: CGRect) {
        

        let w = container.width/7
        let h = w/4
        
        let x = container.width/2 - w/2
        let y = container.height - container.width/4
        
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }


    mutating func styleFillContainer(container: CGRect) {
        
        let x: CGFloat = 0
        let y: CGFloat = 0
        
        let w = container.width
        let h = container.height
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }

    
    mutating func styleLoginTable(_ container: CGRect)
    {
        let w = container.width*6/7
        let x = container.width/2-w/2
        let y = container.width/18 + 1/4*container.height
        let h = container.height - 1.1*y
        
        self = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    mutating func styleConfiguration(_ container: CGRect)
    {
        let h = container.height*0.8
        let w = h
        let x = container.width/2 - w/2
        let y = container.height/2 - h/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
        
    }
    

    // Gets the coordinates for hiding a view in the top left corner.
    mutating func styleHideTopLeft(hide: CGRect) {
        
        let h = hide.height
        let w = hide.width
        let y = -1.2*hide.height
        let x = -1.2*hide.width
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
        
    }
    
    
    
    // Back Button Displayed on top left.
    mutating func styleBackBtn(_ container: CGRect) {
        
        let h = container.height/10
        let w = h
        let y = h/2
        let x = w/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
        
    }
    
    
}




func getResponseButtonFrames(n: Int,container: CGRect) -> [CGRect]
{
    
    var frames: [CGRect] = []
    
    let side: CGFloat = container.width/12
    
    let length = side*CGFloat(n)*1.2
    
    let startX = container.width/2 - length/2
    
    for index in 0...n-1 {
        
        
        let x = 10 + startX + side*CGFloat(index)*1.2
        let y = container.height - 1.5*side
        
        let w = side
        let h = side
        
        frames.append(CGRect(x: x, y: y, width: w, height: h))
        
        
    }
    
    return frames
    
}



// Right now the trophies are buttons.
func getTrophyButtonFrames(n: Int,container: CGRect) -> [CGRect]
{
    
    var frames: [CGRect] = []
    
    let spacing: CGFloat = container.width/12
    
    let side: CGFloat = container.width/25
    
    let startX = 10 + spacing/2 - side/2
    
    for index in 0...n-1 {
        
        
        let x = startX + spacing*CGFloat(index)*1.2
        let y = container.height - 4*side
        
        let w = side
        let h = side
        
        frames.append(CGRect(x: x, y: y, width: w, height: h))
        
        
    }
    
    return frames
    
}





extension UIButton {
    
    
    func StyleAddBtn(container: CGRect) {
        
        
        var _frame: CGRect {
            
            let h = container.width/6
            let w = h
            let x = container.width -  h
            let y = container.height/2
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
    
        self.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: 100)
        self.setTitle("+", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.frame = _frame
        
    
        
    }
    
    func StyleSubBtn(container: CGRect) {
        
        var _frame: CGRect {
            
            let h = container.width/6
            let w = h
            let x = CGFloat(0)
            let y = container.height/2
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        
        self.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: 100)
        self.setTitle("-", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.frame = _frame
        
        
    }

    
    // Styles the button as a pink rectangle with chalkboard SE font.
    func styleChalkRect(text: String) {
        
        guard self.frame.height != 0 else {
            
            print("must Specify a frame befor styling")
            
            return 
        }
        
        let fontsize = self.frame.height*0.5
        
        self.setBackgroundImage(PinkButton, for: .normal)
        
        self.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: fontsize)
        
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.setTitle(text, for: .normal)
        
    
    }
    
    func styleArrowBack()
    {
        
        
        let fontsize = self.frame.height
    
        self.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: fontsize)
        
        self.setTitleColor(UIColor.gray, for: .normal)
        
        self.setTitle("<", for: .normal)
    }
    
}


