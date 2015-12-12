//
//  Constants.swift
//  Fruit
//
//  Created by 戢婧祎 on 28/11/15.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


let file_ropeData = "RopeData"
let file_gameData = "GameData"

let ropeTextureImage = "ropeTexture"
let ropeHolderImage = "ropeHolder"

let image_pig_1 = "pig_1"
let image_pig_2 = "pig_2"
let image_pig_3 = "pig_3"
let image_title = "title"
let image_chatbox = "chatbox"
let image_btn_blue_up = "btn_blue_up"
let image_btn_blue_down = "btn_blue_down"

let image_life = "spaceship"
let image_prize = "spaceship"
let image_bomb = "meteor"
let image_earth = "earth"
let image_murcury = "murcury"
let image_varnus = "varnus"
let image_saturn = "saturn"

let name_prize = "prize"
let name_earth = "earth"
let name_planet = "planet"
let name_rope = "rope"
let name_enemy = "enemy"
let name_bomb = "bomb"
let name_add_life = "add_life"
let name_btn_restart = "restart"
let name_btn_back = "back"
let name_btn_normalGame = "btn_game_0"
let name_btn_timeGame = "btn_game_1"
let name_btn_diyGame = "btn_game_2"

let enemyCutEffect = "sliceHitEnemy.sks"
let bombCutEffect = "sliceHitBomb.sks"


let passScore_lv1 = 50

let maxLife = 3

let key_creat_planet = "creat_planet"
let key_rotate_earth = "rotate_earth"
let key_rotate_planet = "rotate_planet"


let transitions = [
    SKTransition.doorsOpenHorizontalWithDuration(1.0),
    SKTransition.doorsOpenVerticalWithDuration(1.0),
    SKTransition.doorsCloseHorizontalWithDuration(1.0),
    SKTransition.doorsCloseVerticalWithDuration(1.0),
    SKTransition.flipHorizontalWithDuration(1.0),
    SKTransition.flipVerticalWithDuration(1.0),
    SKTransition.moveInWithDirection(.Left, duration:1.0),
    SKTransition.pushWithDirection(.Right, duration:1.0),
    SKTransition.revealWithDirection(.Down, duration:1.0),
    SKTransition.crossFadeWithDuration(1.0),
    SKTransition.fadeWithColor(UIColor.darkGrayColor(), duration:1.0),
    SKTransition.fadeWithDuration(1.0)
]


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
    static let planet: UInt32 = 32
    static let bomb: UInt32 = 64
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


