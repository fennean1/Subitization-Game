//
//  ResponseButton.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/21/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit



class trophybutton: UIButton {
    
    // Level This Trophy Corresponds to. We're only dealing with one level so this is irrelevent at the moment.
    var level = 0
    

    func updateTrophy(percentage: CGFloat) {
        
        let newTrophy = getTrophy(percentage: percentage)
      
        self.setImage(newTrophy, for: .normal)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


