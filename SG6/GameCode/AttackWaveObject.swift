//
//  AttackWaveObject.swift
//  Alienable Rights
//
//  Created by terrybfoster on 6/14/18.
//  Copyright © 2018 terrybfoster. All rights reserved.
//

import Foundation
//********************************************************************
public class AttackWaveObject
{
    var count:                      [gameTypes: Int] = [:]
    var max:                        [gameTypes: Int] = [:]
    var points:                     [gameTypes: Int] = [:]
    var pointsPerWave:              Int = 0
    
    //********************************************************************
    init() {
        count[.g1] = 0; max[.g1] = 0; points[.g1] = 0
        count[.g2] = 0; max[.g2] = 0; points[.g2] = 0
        count[.g3] = 0; max[.g3] = 0; points[.g3] = 0
        count[.g4] = 0; max[.g4] = 0; points[.g4] = 0
        count[.g5] = 0; max[.g5] = 0; points[.g5] = 0
        count[.g6] = 0; max[.g6] = 0; points[.g6] = 0
        pointsPerWave = 0
    }
    //********************************************************************
    func updateValues(vGameType: gameTypes, vCount: Int, vMax: Int, vPoints: Int) {
        count[vGameType] = vCount
        max[vGameType] = vMax
        points[vGameType] = vPoints
    }
    //********************************************************************
    func getCount(vGameType: gameTypes) -> Int { return count[vGameType]! }
    //********************************************************************
    func getMax(vGameType: gameTypes) -> Int { return max[vGameType]! }
    //********************************************************************
    func getPoints(vGameType: gameTypes) -> Int { return points[vGameType]! }
    //********************************************************************
    func getTotalPointsForWave() -> Int { return pointsPerWave }
    //********************************************************************
    func getTotalObjectsForWave() -> Int { return count[.g1]! + count[.g2]! + count[.g3]! + count[.g4]! + count[.g5]! + count[.g6]! }
    //********************************************************************
    func getTotalMoneyForWave() -> Int
    {
        let g1Money = getCount(vGameType: .g1) * 1
        let g2Money = getCount(vGameType: .g2) * 2
        let g3Money = getCount(vGameType: .g3) * 3
        let g4Money = getCount(vGameType: .g4) * 4
        let g5Money = getCount(vGameType: .g5) * 5
        let g6Money = getCount(vGameType: .g6) * 6
        let totalMoneyPerWave = g1Money + g2Money + g3Money + g4Money + g5Money + g6Money
        return totalMoneyPerWave
    }
    //********************************************************************
}
