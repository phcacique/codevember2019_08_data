//
//  GameScene.swift
//  Data
//
//  Created by Pedro Cacique on 08/11/19.
//  Copyright © 2019 Pedro Cacique. All rights reserved.
//

import SpriteKit
import GameplayKit
import SwiftGameOfLife

class GameScene: SKScene {
    
    var cellSize:CGFloat = 40
    var grid: Grid = Grid()
    var renderTime: TimeInterval = 0
    let duration: TimeInterval = 0.2
    
    static let mainColor:UIColor = UIColor(red:75/255, green:75/255, blue:75/255, alpha:1)
    static let deadColor:UIColor = UIColor(red:61/255, green:61/255, blue:61/255, alpha:1)
    static let deadColor2:UIColor = UIColor(red:20/255, green:20/255, blue:20/255, alpha:1)
    static let gonnaDie:UIColor = UIColor(red:255/255, green:82/255, blue:82/255, alpha:1)
    static let gonnaLive:UIColor = UIColor(red:51/255, green:217/255, blue:178/255, alpha:1)
    static let gonnaBirth:UIColor = UIColor(red:255/255, green:177/255, blue:66/255, alpha:1)
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = GameScene.mainColor.withAlphaComponent(0.5)
        restart()
    }
    
    func restart(){
        setupGrid()
        showGen()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        restart()
    }
    
    func setupGrid(){
        grid = Grid(width: Int(UIScreen.main.bounds.size.width / cellSize) + 1,
                    height: Int(UIScreen.main.bounds.size.height / cellSize) + 1,
                    isRandom: true)
        grid.addRule(CountRule(name: "Solitude", startState: .alive, endState: .dead, count: 2, type: .lessThan))
        grid.addRule(CountRule(name: "Survive2", startState: .alive, endState: .alive, count: 2, type: .equals))
        grid.addRule(CountRule(name: "Survive3", startState: .alive, endState: .alive, count: 3, type: .equals))
        grid.addRule(CountRule(name: "Overpopulation", startState: .alive, endState: .dead, count: 3, type: .greaterThan))
        grid.addRule(CountRule(name: "Birth", startState: .dead, endState: .alive, count: 3, type: .equals))
    }
    
    func showGen(showLabels:Bool = true){
        
        removeAllChildren()
        
        for i in 0..<grid.width {
            for j in 0..<grid.height{
                
                let (color, neighbors) = getColor(i, j)
                
                
                var node: SKShapeNode = SKShapeNode(rect: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                addChild(node)
//                node.fillColor = GameScene.deadColor.withAlphaComponent(0.2)
                node.lineWidth = 1
                node.strokeColor = GameScene.deadColor
                
                let value = SKLabelNode(text: "\(neighbors)")
                value.fontColor = color
                value.fontSize = 20
                value.fontName = "SanFranciscoDisplay-Heavy"
                value.position = CGPoint(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize)
                value.position.x += cellSize/2
                value.position.y += cellSize/2 - value.frame.size.height/2
                addChild(value)
                
            }
        }
    }
    
    func getColor(_ i:Int, _ j:Int) -> (UIColor, Int ){
        let n = grid.getLiveNeighbors(cell: grid.cells[i][j]).count
        let state = grid.cells[i][j].state
        if state == .alive {
            if n > 3  || n < 2{
                return (GameScene.gonnaDie, n)
            } else {
                return (GameScene.gonnaLive, n)
            }
        } else {
            if n == 3 {
                return (GameScene.gonnaBirth, n)
            }
        }
        return (GameScene.deadColor, n)
    }

    override func update(_ currentTime: TimeInterval) {
        if currentTime > renderTime {
            grid.applyRules()
            showGen()
            renderTime = currentTime + duration
        }
    }
}
