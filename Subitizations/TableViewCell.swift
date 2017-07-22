//
//  CustomCell.swift
//  Math Fact Workout by NumberShapes
//
//  Created by Andrew Fenner on 4/26/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class playercell: UITableViewCell
{
    
    var img = UIImageView()
    let descLbl = UILabel()
    let pointsLbl = UILabel()
    
    override func layoutSubviews()
    {
        
        super.layoutSubviews()
        
        let container = superview!.frame
        
        let backcolor = cellcolor
        
        self.backgroundColor = backcolor
        
        var imgframe: CGRect
        {
            
            let h = self.frame.height
            let w = h
            let x = CGFloat(0)
            
            return CGRect(x: x, y: 0, width: w, height: h)
        }
        
        img.frame = imgframe
        self.contentView.addSubview(img)
        
        var desclblFrame: CGRect
        {
            
            let h = self.frame.height
            let x = h + imgframe.origin.x
            let w = self.frame.width - x
            let y = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var pointsframe: CGRect
        {
            
            let h = self.frame.height
            let w = 4*h
            let x = self.frame.width - w
            let y = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        descLbl.frame = desclblFrame
        // descLbl.chalkboardfont()
        self.contentView.addSubview(descLbl)
        
        pointsLbl.frame = pointsframe
        // pointsLbl.chalkboardfont()
        self.contentView.addSubview(pointsLbl)
        
    }
    
}

