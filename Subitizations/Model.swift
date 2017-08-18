//
//  Model.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/13/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


// Normalizes the score percentage
let Normalizer: CGFloat = 200

// Size of the ball
var BallSize: CGFloat = 50

var BackGround = UIImageView()

var ColorState = colorstate.blue

// Array of marbles that get displayed during the game
var Marbles: [marble] = []

// The array of points that represent the marble centers
var MarbleCenters: [CGPoint] = []

// The number being presented.
var Argument = 0


// The two marbles that will be used in a given turn. User can choose these at the beginning of the game and may change them between turns.
var MainMarble = BlueBall
var AccentMarble = OrangeBall

// Game Timer
var Time: Double = 0

var TimeElapsed: Double = 0

// Array of buttons that receive the user's responses to the question
var ResponseButtons: [responsebutton] = []

var TrophyButtons: [trophybutton] = []

var Countdown: Float = 60


// Why do I need this? (I think it's for the trophy array
var NumberOfTrophies = 10

// Number of response buttons that are displayed.  I think this will always be ten but made room for the possibility that the number of response buttons may vary.
var NumberOfButtons = 10


// This variable should only last for the lifetime of the player.
var Score: CGFloat = 0


//
//  Modle.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 4/18/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

var Toggler = 0


// Convenience:

var Balls: [touchableBall] = []

var BallsInPlay = 14

// UIElements

var addBtn = UIButton()
var subBtn = UIButton()

var BallDim: CGFloat = 0

// Initialize counter
var counter = UIImage(named: "PurpleBall")

var centerOfScreen: CGPoint!

let BallArray = [BlueBall,OrangeBall,RedBall,GreenBall,PinkBall,PurpleBall]

var colorSwitching = false

var Split = false

var counterimage = BlueBall

var originalCoordinates: [CGPoint] = []

var numbershapeViewOrigin: CGPoint!

var a = 10
var b = 4

var Scattered = false


//// Functions


/* Give the ballsize as a function of the frame. Optimally set to an eighth of the width
func ballsize(frame: CGSize) -> CGSize {
    
    let h = frame.height/5
    let w = h
    
    return CGSize(width: h, height: w)
    
}

 */
 
var NumberShapeFrame: CGRect!

/* Removed due to redeclaration

// Ball Radius
var r: CGFloat!

*/
 
//// Animations
let animationSpeed = 0.5




