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

var TrophyButtons: [trophybutton] = []

var Countdown: Float = 60

var NumberOfTrophies = 10
var NumberOfButtons = 10

var Score: CGFloat = 0


