//  Created by Andrew Fenner on 4/18/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.

import Foundation
import UIKit


// Normalizes the score percentage
let Normalizer: CGFloat = 200

// Size of the ball
var BallSize: CGFloat = 50

var BackGround = UIImageView()


var ColorState = colorstate.blue

// The array of points that represent the marble centers
var MarbleCenters: [CGPoint] = []


var Countdown: Float = 60

// Why do I need this? (I think it's for the trophy array
var NumberOfTrophies = 10

// Number of response buttons that are displayed.  I think this will always be ten but made room for the possibility that the number of response buttons may vary.
var NumberOfButtons = 10


var Toggler = 0

var BallDim: CGFloat = 0

var centerOfScreen: CGPoint!

let BallArray = [BlueBall,OrangeBall,RedBall,GreenBall,PinkBall,PurpleBall]

var colorSwitching = false

var x: String = "0"

var counterimage = BlueBall

var originalCoordinates: [CGPoint] = []

var numbershapeViewOrigin: CGPoint!

var a = 5
var b = 0

var NumberShapeFrame: CGRect!




