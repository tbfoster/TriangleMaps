
import SceneKit
import Foundation
//********************************************************************
// Game settings
//
// Attack life is multipled by a factor for each game level * the number of levels.
//    G3 thorugh G5 continue to engage up through level 35, at that point all are in play.
//    Attackers get stronger after level 40, depending on the game level selected.
//
// Money, Escapes, Repairs, and Bonus are set by game level.
//********************************************************************
class GameSettings
{
    var G1MaxLife0: [Int:CGFloat] = [0:0]                                 // G3 MaxLife accelerant
    var G2MaxLife0: [Int:CGFloat] = [0:0]                                 // ...
    var G3MaxLife0: [Int:CGFloat] = [0:0]                                 // ...
    var G4MaxLife0: [Int:CGFloat] = [0:0]
    var G5MaxLife0: [Int:CGFloat] = [0:0]
    var G6MaxLife0: [Int:CGFloat] = [0:0]
    
    var G1MaxLife1: [Int:CGFloat] = [0:0]                                 // G3 MaxLife accelerant
    var G2MaxLife1: [Int:CGFloat] = [0:0]                                 // ...
    var G3MaxLife1: [Int:CGFloat] = [0:0]                                 // ...
    var G4MaxLife1: [Int:CGFloat] = [0:0]
    var G5MaxLife1: [Int:CGFloat] = [0:0]
    var G6MaxLife1: [Int:CGFloat] = [0:0]
    
    var G1MaxLife2: [Int:CGFloat] = [0:0]                                 // G3 MaxLife accelerant
    var G2MaxLife2: [Int:CGFloat] = [0:0]                                 // ...
    var G3MaxLife2: [Int:CGFloat] = [0:0]                                 // ...
    var G4MaxLife2: [Int:CGFloat] = [0:0]
    var G5MaxLife2: [Int:CGFloat] = [0:0]
    var G6MaxLife2: [Int:CGFloat] = [0:0]
    
    var G1Multipler0: CGFloat = 6.5  / 80                                 // Multiplier for enemies, make the stronger as levels increase
    var G2Multipler0: CGFloat = 10.9 / 80                                 // ...
    var G3Multipler0: CGFloat = 18.6 / 80                                 // ...
    var G4Multipler0: CGFloat = 31.4 / 80
    var G5Multipler0: CGFloat = 40.8 / 80
    var G6Multipler0: CGFloat = 89.6 / 80
    
    var G1Multipler1: CGFloat = 6.5  / 60                                 // Multiplier for enemies, make the stronger as levels increase
    var G2Multipler1: CGFloat = 10.9 / 60                                 // ...
    var G3Multipler1: CGFloat = 18.6 / 60                                 // ...
    var G4Multipler1: CGFloat = 31.4 / 60
    var G5Multipler1: CGFloat = 40.8 / 60
    var G6Multipler1: CGFloat = 89.6 / 60
    
    var G1Multipler2: CGFloat = 6.5  / 40                                 // Multiplier for enemies, make the stronger as levels increase
    var G2Multipler2: CGFloat = 10.9 / 40                                 // ...
    var G3Multipler2: CGFloat = 18.6 / 40                                 // ...
    var G4Multipler2: CGFloat = 31.4 / 40
    var G5Multipler2: CGFloat = 40.8 / 40
    var G6Multipler2: CGFloat = 89.6 / 40
    // OR here to reduce hard level
    //**********************************************************
    init()
    {
        for vLoop in 1...150
        {
            G1MaxLife0[vLoop] = 6.5
            G2MaxLife0[vLoop] = 10.9
            G3MaxLife0[vLoop] = 18.6
            G4MaxLife0[vLoop] = 31.4
            G5MaxLife0[vLoop] = 40.8
            G6MaxLife0[vLoop] = 89.6
            
            G1MaxLife1[vLoop] = 6.5
            G2MaxLife1[vLoop] = 10.9
            G3MaxLife1[vLoop] = 18.6
            G4MaxLife1[vLoop] = 31.4
            G5MaxLife1[vLoop] = 40.8
            G6MaxLife1[vLoop] = 89.6
            
            G1MaxLife2[vLoop] = 6.5
            G2MaxLife2[vLoop] = 10.9
            G3MaxLife2[vLoop] = 18.6
            G4MaxLife2[vLoop] = 31.4
            G5MaxLife2[vLoop] = 40.8
            G6MaxLife2[vLoop] = 89.6
        }
        var vG3Increment0: CGFloat = 0
        var vG4Increment0: CGFloat = 0
        var vG5Increment0: CGFloat = 0
        var vG6Increment0: CGFloat = 0
        var vG7Increment0: CGFloat = 0
        var vG8Increment0: CGFloat = 0
        
        
        var vG3Increment1: CGFloat = 0
        var vG4Increment1: CGFloat = 0
        var vG5Increment1: CGFloat = 0
        var vG6Increment1: CGFloat = 0
        var vG7Increment1: CGFloat = 0
        var vG8Increment1: CGFloat = 0
        
        var vG3Increment2: CGFloat = 0
        var vG4Increment2: CGFloat = 0
        var vG5Increment2: CGFloat = 0
        var vG6Increment2: CGFloat = 0
        var vG7Increment2: CGFloat = 0
        var vG8Increment2: CGFloat = 0
        
        // At level 50, attack deployment is at full capability.  Increase enemy strength at each new level
        for vLoop in 40...125  // Can't go over 125 game levels and can't draw from DATA
        {
            vG3Increment0 += G1Multipler0
            G1MaxLife0[vLoop] = G1MaxLife0[vLoop]! + vG3Increment0
            
            vG4Increment0 += G2Multipler0
            G2MaxLife0[vLoop] = G2MaxLife0[vLoop]! + vG4Increment0
            
            vG5Increment0 += G3Multipler0
            G3MaxLife0[vLoop] = G3MaxLife0[vLoop]! + vG5Increment0
            
            vG6Increment0 += G4Multipler0
            G4MaxLife0[vLoop] = G4MaxLife0[vLoop]! + vG6Increment0
            
            vG7Increment0 += G5Multipler0
            G5MaxLife0[vLoop] = G5MaxLife0[vLoop]! + vG7Increment0
            
            vG8Increment0 += G6Multipler0
            G6MaxLife0[vLoop] = G6MaxLife0[vLoop]! + vG8Increment0
            
            // Level 1
            vG3Increment1 += G1Multipler1
            G1MaxLife1[vLoop] = G1MaxLife1[vLoop]! + vG3Increment1
            
            vG4Increment1 += G2Multipler1
            G2MaxLife1[vLoop] = G2MaxLife1[vLoop]! + vG4Increment1
            
            vG5Increment1 += G3Multipler1
            G3MaxLife1[vLoop] = G3MaxLife1[vLoop]! + vG5Increment1
            
            vG6Increment1 += G4Multipler1
            G4MaxLife1[vLoop] = G4MaxLife1[vLoop]! + vG6Increment1
            
            vG7Increment1 += G5Multipler1
            G5MaxLife1[vLoop] = G5MaxLife1[vLoop]! + vG7Increment1
            
            vG8Increment1 += G6Multipler1
            G6MaxLife1[vLoop] = G6MaxLife1[vLoop]! + vG8Increment1
            
            // Level 2
            vG3Increment2 += G1Multipler2
            G1MaxLife2[vLoop] = G1MaxLife2[vLoop]! + vG3Increment2
            
            vG4Increment2 += G2Multipler2
            G2MaxLife2[vLoop] = G2MaxLife2[vLoop]! + vG4Increment2
            
            vG5Increment2 += G3Multipler2
            G3MaxLife2[vLoop] = G3MaxLife2[vLoop]! + vG5Increment2
            
            vG6Increment2 += G4Multipler2
            G4MaxLife2[vLoop] = G4MaxLife2[vLoop]! + vG6Increment2
            
            vG7Increment2 += G5Multipler2
            G5MaxLife2[vLoop] = G5MaxLife2[vLoop]! + vG7Increment2
            
            vG8Increment2 += G6Multipler2
            G6MaxLife2[vLoop] = G6MaxLife2[vLoop]! + vG8Increment2
        }
        
//        data.consoleMessage(vString: "Game Level 0 - Easy")
//        data.consoleMessage(vString: "|Wave|  G3  |   G4  |   G5  |   G6  |   G7  |   G8  |  G3  |   G4  |   G5  |   G6  |   G7  |   G8  |  G3  |   G4  |   G5  |   G6  |   G7  |   G8  |")
//        for vLoop in 1...110
//        {
//            let vWave = String(format: "%03d", vLoop)
//            let vG3Max0 = String(format: "%3.1f", G3MaxLife0[vLoop]!)
//            let vG4Max0 = String(format: "%3.1f", G4MaxLife0[vLoop]!)
//            let vG5Max0 = String(format: "%3.1f", G5MaxLife0[vLoop]!)
//            let vG6Max0 = String(format: "%3.1f", G6MaxLife0[vLoop]!)
//            let vG7Max0 = String(format: "%3.1f", G7MaxLife0[vLoop]!)
//            let vG8Max0 = String(format: "%3.1f", G8MaxLife0[vLoop]!)
//
//            let vG3Max1 = String(format: "%3.1f", G3MaxLife1[vLoop]!)
//            let vG4Max1 = String(format: "%3.1f", G4MaxLife1[vLoop]!)
//            let vG5Max1 = String(format: "%3.1f", G5MaxLife1[vLoop]!)
//            let vG6Max1 = String(format: "%3.1f", G6MaxLife1[vLoop]!)
//            let vG7Max1 = String(format: "%3.1f", G7MaxLife1[vLoop]!)
//            let vG8Max1 = String(format: "%3.1f", G8MaxLife1[vLoop]!)

//            let vG3Max2 = String(format: "%3.1f", G3MaxLife2[vLoop]!)
//            let vG4Max2 = String(format: "%3.1f", G4MaxLife2[vLoop]!)
//            let vG5Max2 = String(format: "%3.1f", G5MaxLife2[vLoop]!)
//            let vG6Max2 = String(format: "%3.1f", G6MaxLife2[vLoop]!)
//            let vG7Max2 = String(format: "%3.1f", G7MaxLife2[vLoop]!)
//            let vG8Max2 = String(format: "%3.1f", G8MaxLife2[vLoop]!)
//
//            data.consoleMessage(vString: "|\(vWave) | \(vG3Max0) | \(vG4Max0) | \(vG5Max0) | \(vG6Max0) | \(vG7Max0) | \(vG8Max0) | \(vG3Max1) | \(vG4Max1) | \(vG5Max1) | \(vG6Max1) | \(vG7Max1) | \(vG8Max1) | \(vG3Max2) | \(vG4Max2) | \(vG5Max2) | \(vG6Max2) | \(vG7Max2) | \(vG8Max2) ")
//        }
    }
    //**********************************************************
    func getMaxLife(vGameType: gameTypes, vLevel: Int, vWave: Int) -> CGFloat
    {
        switch(vLevel)
        {
        case 0: return getMaxLifeLevel0(vGameType: vGameType, vWave: vWave)
        case 1: return getMaxLifeLevel1(vGameType: vGameType, vWave: vWave)
        case 2: return getMaxLifeLevel2(vGameType: vGameType, vWave: vWave)
        default: return 0
        }
    }
    //**********************************************************
    func getMaxLifeLevel0(vGameType: gameTypes, vWave: Int) -> CGFloat
    {
        switch vGameType
        {
        case .g1:
            return G1MaxLife0[vWave]!
        case .g2:
            return G2MaxLife0[vWave]!
        case .g3:
            return G3MaxLife0[vWave]!
        case .g4:
            return G4MaxLife0[vWave]!
        case .g5:
            return G5MaxLife0[vWave]!
        case .g6:
            return G6MaxLife0[vWave]!
        default:
            break
        }
        return 0
    }
    //**********************************************************
    func getMaxLifeLevel1(vGameType: gameTypes, vWave: Int) -> CGFloat
    {
        switch vGameType
        {
        case .g1:
            return G1MaxLife1[vWave]!
        case .g2:
            return G2MaxLife1[vWave]!
        case .g3:
            return G3MaxLife1[vWave]!
        case .g4:
            return G4MaxLife1[vWave]!
        case .g5:
            return G5MaxLife1[vWave]!
        case .g6:
            return G6MaxLife1[vWave]!
        default:
            break
        }
        return 0
    }
    //**********************************************************
    func getMaxLifeLevel2(vGameType: gameTypes, vWave: Int) -> CGFloat
    {
        switch vGameType
        {
        case .g1:
            return G1MaxLife2[vWave]!
        case .g2:
            return G2MaxLife2[vWave]!
        case .g3:
            return G3MaxLife2[vWave]!
        case .g4:
            return G4MaxLife2[vWave]!
        case .g5:
            return G5MaxLife2[vWave]!
        case .g6:
            return G6MaxLife2[vWave]!
        default:
            break
        }
        return 0
    }
    //********************************************************************
}
