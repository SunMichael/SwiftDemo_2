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
func swapTwoValues<T>(inout a:T , inout b:T){    //泛型函数 <T>占位类型  a，b参数类型要一致
    let temporary = a
    a = b
    b = temporary
}

struct IntStack : Container{           //将此例中的int 换成T 就是泛型版本 栈
    // IntStack 的原始实现
    var items = [Int]()
    mutating func push(item: Int){
        items.append(item)
    }
    mutating func pop() ->Int {
        return items.removeLast()
    }
    
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: ItemType) {
        self.push(item)
    }
     var count: Int {
        return items.count
    }
    subscript(i :Int) ->Int{
        return items[i]
    }
}

func findStringIndex<T :Equatable>(array: [T] ,valueToFind: T) -> Int?{  //T 要遵循Equatable协议 此协议是实现了 == 和 != 比较的类型
    for (index ,value) in enumerate(array){
        if value == valueToFind {
            return index
        }
    }
    return nil
}


protocol Container {
    typealias ItemType     //声明关联类型
    mutating func append(item :ItemType)
     var count: Int {get}
    subscript(i: Int) -> ItemType{
        get
    }
}

// 类型约束
func allItemsMatch <C1: Container ,C2: Container where C1.ItemType == C2.ItemType ,C1.ItemType: Equatable> (someContainer: C1 , anotherContainer: C2) ->Bool {
    if someContainer.count != anotherContainer.count {
        return false
    }
    for i in 0 ..< someContainer.count {
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    return true
}
//C1和C2是容器的两个占位类型参数 遵循Container协议，C1的itemType 遵循Equatable协议，<> 表示占位参数类型


