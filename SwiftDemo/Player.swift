//
//  Player.swift
//  SwiftDemo
//
//  Created by keyrun on 15-1-26.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

import Foundation

class Player {
    let playerName :String
    var tracker = LevelTracker()
    
    func completeLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceLevel(level + 1)
    }
    init(name:String){
        playerName = name
    }
    
    struct LevelTracker {
        static var hightestUnlockedLevel = 1
        static func unlockLevel(level: Int){
            if level > hightestUnlockedLevel {
                hightestUnlockedLevel = level
            }
        }
        static func levelIsUnlocked(level: Int) ->Bool {
            return level <= hightestUnlockedLevel
        }
        var currentLevel = 1
        mutating func advanceLevel(level: Int) ->Bool {
            if (LevelTracker.levelIsUnlocked(level)){
                currentLevel = level
                return true
            }else{
                return false
            }
        }
        
    }
    
}


struct Bank {
    static var coinsBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) ->Int{
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsBank)
        coinsBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receivedCoins(coins: Int){
        coinsBank += coins
    }
}

class  Player2 {
    var coinInPurse: Int
    init(coins: Int){
        coinInPurse = Bank.vendCoins(coins)
    }
    func winConus(coins: Int){
        coinInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receivedCoins(coinInPurse)          //析构函数
    }
}


// change there







