//
//  Model.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/13/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


// Only for testing purposes.
var Toggler = 0


// Size of the ball
var BallSize: CGFloat = 50

var BackGround = UIImageView()


// Array of marbles that get displayed during the game
var Marbles: [marble] = []

// The array of points that represent the marble centers
var MarbleCenters: [CGPoint] = []

var CurrentCounter = PinkBall

// The number being presented.
var Argument = 0

// Game Timer
var Time: Double = 0

var TimeElapsed: Double = 0

// Array of buttons that receive the user's responses to the question
var ResponseButtons: [responsebutton] = []

// A struct that stores the levels.
var Levels = levels()

var Countdown: Float = 60

var NumberOfButtons = 8

var Score: CGFloat = 0


