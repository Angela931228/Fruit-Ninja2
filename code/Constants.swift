//
//  Constants.swift
//  Fruit
//
//  Created by 戢婧祎 on 28/11/15.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation
import UIKit


let ropeDataFile = "RopeData"
let ropeTextureImage = "ropeTexture"
let ropeHolderImage = "ropeHolder"

let image_life = "spaceship"
let image_prize = "spaceship"
let image_bomb = "sun"
let image_earth = "earth"
let image_murcury = "murcury"
let image_varnus = "varnus"
let image_saturn = "saturn"

let name_prize = "prize"
let name_rope = "rope"
let name_enemy = "enemy"
let name_bomb = "bomb"
let name_add_life = "add_life"

let enemyCutEffect = "sliceHitEnemy.sks"
let bombCutEffect = "sliceHitBomb.sks"


let passScore_lv1 = 50

let maxLife = 3

let key_creat_planet = "creat_planet"
let key_rotate_earth = "rotate_earth"



let CanCutMultipleRopeAtOnce  = false

enum Bomb{
    case mustBomb, noBomb, random
}

enum SequenceType: Int {
    case OneNoBomb, One, TwoWithOneBomb, Tow, Three, Four, Chain, FastChain, Bomb
}


struct Category
{
    static let earth: UInt32 = 1
    static let enemy: UInt32 = 2
    static let Rope: UInt32 = 4
    static let RopeHolder: UInt32 = 8
    static let Prize: UInt32 = 16
}


struct Zposition {
    static let background:CGFloat = 0
    static let planet:CGFloat = 1
    static let rope:CGFloat = 2
    static let prize:CGFloat = 3
    static let label:CGFloat = 4
    static let slice:CGFloat = 5
    static let labeltop:CGFloat = 6
}