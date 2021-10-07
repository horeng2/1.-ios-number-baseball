//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation


func createRandomNumbers() -> [Int] {
    let shuffledNumbers = [Int](1...9).shuffled()
    let threeNumbers = [Int](shuffledNumbers[0...2])
    return threeNumbers
}

func calculateBallCount(index: Int, matchIndex: Int?, strikeCount: inout Int, ballCount: inout Int) {
    if matchIndex == nil {
        return
    } else if matchIndex == index {
        strikeCount += 1
    } else {
        ballCount += 1
    }
}

func checkBallCount(answerNumbers: [Int], userNumbers: [Int]) -> [Int] {
    guard answerNumbers != userNumbers else {
        return [3, 0]
    }
    var strikeCount: Int = 0
    var ballCount: Int = 0
    
    for index in 0...2 {
        let matchIndex = answerNumbers.firstIndex(of: userNumbers[index])
        calculateBallCount(index: index, matchIndex: matchIndex, strikeCount: &strikeCount, ballCount: &ballCount)
    }
    return [strikeCount, ballCount]
}

var randomAnswerNumbers = createRandomNumbers()
var gameCount = 9

func printVictoryMessage(gameChance gameCount: Int, strikeScore strikeCount: Int) {
    if gameCount == 0 && strikeCount < 3 {
        print("컴퓨터 승리…!")
    } else if strikeCount == 3 {
        print("사용자 승리!")
    }
}

func startGame() {
    while gameCount > 0 {
        gameCount -= 1
        let userNumbers = createRandomNumbers()
        let gameScore = checkBallCount(answerNumbers: randomAnswerNumbers, userNumbers: userNumbers)
        let strikeCount = gameScore[0]
        let ballCount = gameScore[1]
        
        print("임의의 수 : \(userNumbers[0]) \(userNumbers[1]) \(userNumbers[2])")
        print("\(strikeCount) 스트라이크, \(ballCount) 볼")
        print("남은 기회 : \(gameCount)")
        
        printVictoryMessage(gameChance: gameCount, strikeScore: strikeCount)
    }
}

func showMenu() {
    print("1. 게임시작\n2. 게임종료\n원하는 기능을 선택해주세요 : ", terminator: "")
    guard let input = readLine() else { return }
    if input == "1" {
        startGame()
    } else if input == "2" {
        return
    } else {
        print("입력이 잘못되었습니다")
        showMenu()
    }
}

showMenu()
