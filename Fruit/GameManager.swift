//
//  GameManager.swift
//  Fruit
//
//  Created by 李骏 on 15/12/8.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//
import Foundation

public class GameManager{
    var name = "000"
    public static let instance = GameManager() //这个位置使用 static，static修饰的变量会懒加载
    
    private init(){
        print("create SwiftSingleton...");
    }
}


