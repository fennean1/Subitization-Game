//
//  ColorPicker.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 6/25/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

enum colorpickertype {
    
    case grid
    case marbles
    
    
}

enum colorstate {
    
    case blue
    case pink
    case red
    case green
    case orange
    case purple
    case nothing
    
}



class colorbutton: UIButton {
    
    // WARNING! Use of "didSet" - I hardly ever do this in this case it's okay since it's just a Bool that's switching on and off.
    var active = false
    {
        didSet {
            
            
            let _x = self.center.x
            var _y = superview!.frame.height/4
            
            if active == true {
                
                
                _y = 3*_y
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.center = CGPoint(x: _x, y: _y)
                    
                    
                })
                
                
            }
            else if active == false && oldValue == true {
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.center = CGPoint(x: _x, y: _y)
                    
                    
                })
                
            }
            else if active == true && oldValue == true
            {
                print("I Shouldn't Be Here")
            }
            
            
            
        }
        
    }
}




extension CGSize
{
    
    mutating func expand(factor: CGFloat)
    {
        self.height = factor*self.height
        self.width = factor*self.height
        
    }
    
}




class colorpicker: UIView {
    
    // Conform to colorManager protocol
    var State = colorstate.blue
    
    
    // This might be stupid. All I'm doing is surveying the buttons to see if any of them are active.
    var active: Bool {
        
        var _active = false
        
        for abutton in buttonArray {
            
            if abutton.active == true
            {
                _active = true
            }
            
        }
        
        return _active
        
    }
    
    
    var nothingButton = colorbutton()
    var blueButton = colorbutton()
    var orangeButton = colorbutton()
    var purpleButton = colorbutton()
    var redButton = colorbutton()
    var greenButton = colorbutton()
    var pinkButton = colorbutton()
    var buttonArray: [colorbutton] = []
    
    
    // Dependency Issue! Can't reuse ColorPicker if it's updating elements from another view controller. It's okay right now since the "addBtn" is currently global. Still must refactor.
    
    func buttonPress(sender: colorbutton)
    {
        
        // sender.type is a bad name, the type is acutally the image associated with this sender. Fix later.
        
        
        // Obviously there's a better way to do this.
        switch sender {
            
        case blueButton:
            
            ColorState = .blue
            addBtn.setTitleColor(BLUE, for: .normal)
            
        case orangeButton:
            
            ColorState = .orange
            addBtn.setTitleColor(ORANGE, for: .normal)
            
        case purpleButton:
            
            ColorState = .purple
            addBtn.setTitleColor(PURPLE, for: .normal)
            
        case pinkButton:
            
            ColorState = .pink
            addBtn.setTitleColor(PINK, for: .normal)
            
            
        case redButton:
            
            ColorState = .red
            addBtn.setTitleColor(RED, for: .normal)
            
            
        case greenButton:
            
            
            ColorState = .green
            addBtn.setTitleColor(GREEN, for: .normal)
            
        case nothingButton:
            
            ColorState = .nothing
            
        default:
            
            State = .blue
            addBtn.setTitleColor(BLUE, for: .normal)
            
        }
        
        counterimage = getMarbleFromColorState(state: ColorState)
        
        
        sender.active = !sender.active
        
        print(sender.active)
        
        for abutton in buttonArray
        {
            if abutton != sender
            {
                abutton.active = false
            }
            
        }
        
        colorSwitching = self.active
        
        
    }
    
    
    
    // Not drawing on init since I want to be able to control when the buttons get drawn
    func drawButtons()
    {
        
        let buttonStep = self.frame.width/7
        
        for (index, button) in buttonArray.enumerated()
        {
            
            let y = CGFloat(0)
            let x = CGFloat(index)*buttonStep
            
            let h = self.frame.height/2
            let w = h
            
            self.addSubview(button)
            
            button.frame =  CGRect(x: x, y: y, width: w, height: h)
            
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Initialization Code
        
        blueButton.setImage(blueBtnImage, for: .normal)
        orangeButton.setImage(orangeBtnImage, for: .normal)
        purpleButton.setImage(purpleBtnImage, for: .normal)
        redButton.setImage(redBtnImage, for: .normal)
        greenButton.setImage(greenBtnImage, for: .normal)
        pinkButton.setImage(pinkBtnImage, for: .normal)
        

        nothingButton.setTitleColor(BLUE, for: .normal)
        nothingButton.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: 50)
        nothingButton.setTitle("X", for: .normal)
        
        
        
        // self.backgroundColor = UIColor.blue
        
        blueButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        orangeButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        purpleButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        redButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        pinkButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        nothingButton.addTarget(self, action: #selector(colorpicker.buttonPress(sender:)), for: .touchUpInside)
        
        
        
        buttonArray = [blueButton,orangeButton,purpleButton,redButton,greenButton,pinkButton,nothingButton]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        
        
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    
    
}


extension UIView
{
    
    func colorpickerStyle(frame: CGRect)
    {
        
        let w = 0.6*frame.width
        let h = w/5
        
        let centerX = frame.width/2
        let centerY = h/2*1.8
        
        self.frame.size = CGSize(width: w, height: h)
        
        self.center = CGPoint(x: centerX, y: centerY)
        
    }
    
    
    
}
