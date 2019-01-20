
import Foundation
import UIKit

//********************************************************************
// User Defaults Helper Class
//********************************************************************
class Defaults
{
    var defaults = UserDefaults.standard
    
    var VERSION: String = "V1.0_" // POINT_RELEASE for game TODO
    
    //********************************************************************
    private func getKeyDescription(vKey: menuButtonTypes, vMap: Int, vLevel: Int) -> String
    {
        var vSaveKey: String = ""
        switch(vKey)
        {
        // Gotit settings
        case .keyShowHelp:             vSaveKey = VERSION + "HELP"; break
        case .keyShowFeatures:         vSaveKey = VERSION + "NEW_FEATURES"; break
        // Saved game vars
        case .keySavedGame:            vSaveKey = "SAVEDGAME--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyWave:                 vSaveKey = "SAVEDGAME-WAVE--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyMoney:                vSaveKey = "SAVEDGAME-MONEY--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyEscapes:              vSaveKey = "SAVEDGAME-ESCAPES--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyPerfectWaves:         vSaveKey = "SAVEDGAME-PERFECT--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyDefenses:             vSaveKey = "SAVEDGAME-DEFENSES--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyDefenseTypes:         vSaveKey = "SAVEDGAME-DEFENSE-TYPES--MAP:\(vMap)LEVEL:\(vLevel)"; break
        case .keyHighScores:           vSaveKey = "HIGHSCORES--MAP:\(vMap)LEVEL:\(vLevel)"; break
        // Achievement vars
        case .keyEasyPlayed:           vSaveKey = "ACHIEVE-EASYPLAYED"; break
        case .keyEasyWon:              vSaveKey = "ACHIEVE-EASYWON"; break
        case .keyEasyNoEscapes:        vSaveKey = "ACHIEVE-EASYNOESCAPES"; break
        case .keyMidPlayed:            vSaveKey = "ACHIEVE-MIDPLAYED"; break
        case .keyMidWin:               vSaveKey = "ACHIEVE-MIDWON"; break
        case .keyMidNoEscapes:         vSaveKey = "ACHIEVE-MIDNOESCAPES"; break
        case .keyHardPlayed:           vSaveKey = "ACHIEVE-HARDPLAYED"; break
        case .keyHardWin:              vSaveKey = "ACHIEVE-HARDWON"; break
        case .keyHardNoEscapes:        vSaveKey = "ACHIEVE-HARDNOESCAPES"; break
        case .keyWarpToVictory:        vSaveKey = "ACHIEVE-WARPTOVICTORY"; break
        case .keyBuyAll:               vSaveKey = "ACHIEVE-BUYALL"; break
        case .keyBuyNoAds:             vSaveKey = "ACHIEVE-NOADDS"; break
        case .keyBuyNewMaps:           vSaveKey = "ACHIEVE-ENABLEMAPS"; break
        // Saved colors
        case .keyInfoTextColor:        vSaveKey = "COLOR-INFO"; break
        // Various settings
        case .keyPlayerLevel:          vSaveKey = "PLAYER-LEVEL"; break
        case .keyAttackTheme:          vSaveKey = "THEME-ATTACK"; break
        case .keyDefenseTheme:         vSaveKey = "THEME-DEFENSE"; break
        case .keyAutoResume:           vSaveKey = "AUTO-RESUME"; break
        case .keyAutoUpgrade:          vSaveKey = "AUTO-UPGRADE"; break
        case .keyZoomLevel:            vSaveKey = "ZOOM-LEVEL"; break
        default:
            print("gameDefaults-> Should not be here!")
            vSaveKey = "NONE-SAVED"
            break
        }
        //print("Dealing with key: \(vSaveKey)")
        return vSaveKey
    }
    //********************************************************************
    //    Key:"COLOR-BACKDROP", Value:0.2:0.3:0.4:1.0
    // Pass default to getUIColorForKey, if not found return default
    //********************************************************************
    func hasUIColorForKey(vKey: menuButtonTypes) -> Bool
    {
        let stringColor = defaults.string(forKey: getKeyDescription(vKey: vKey, vMap: 0, vLevel: 0)) ?? "N"
        if(stringColor == "N")
        {
            print("\(vKey) was not found in NSDEFAULTS, which is OK")
            return false
        }
        return true
    }
    //********************************************************************
    func getUIColorForKey(vKey: menuButtonTypes, vColor: Int) -> Float
    {
        let stringColor = defaults.string(forKey: getKeyDescription(vKey: vKey, vMap: 0, vLevel: 0)) ?? "N"
        if(stringColor == "N")
        {
            print("\(vKey) NOT FOUND ERROR, should NOT be here!")
            return 0
        }
        else
        {
            //print("Loading default string for \(vKey) \(stringColor)")
            let array = stringColor.components(separatedBy: ",")
            guard let vRed = NumberFormatter().number(from: array[0])   else { print("NOT FOUND FORMAT ERROR"); return  0 }
            guard let vGreen = NumberFormatter().number(from: array[1]) else { print("NOT FOUND FORMAT ERROR"); return  0 }
            guard let vBlue = NumberFormatter().number(from: array[2])  else { print("NOT FOUND FORMAT ERROR"); return  0 }
            guard let vAlpha = NumberFormatter().number(from: array[3]) else { print("NOT FOUND FORMAT ERROR"); return  0 }
            
            switch vColor
            {
            case 0: return vRed.floatValue
            case 1: return vGreen.floatValue
            case 2: return vBlue.floatValue
            case 3: return vAlpha.floatValue
            default:
                return 0
            }
        }
    }
    //********************************************************************
    func setUIColorForKey(vKey: menuButtonTypes, vRed: CGFloat, vGreen: CGFloat, vBlue: CGFloat, vAlpha: CGFloat)
    {
        let vSavedKey = getKeyDescription(vKey: vKey, vMap: 0, vLevel: 0)
        let vString = String(format: "%0.03f", vRed) + "," + String(format: "%0.03f", vGreen) + "," + String(format: "%0.03f", vBlue) + "," + String(format: "%0.03f", vAlpha)
        
        //let vString = "\(vRed),\(vGreen),\(vBlue),\(vAlpha)"
        
        defaults.set(vString, forKey: vSavedKey)
        //print("Saved: \(vSavedKey) \(vString)")
    }
    //********************************************************************
    func setIntForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int, vValue: Int)
    {
        defaults.set(vValue, forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel))
    }
    //********************************************************************
    func getIntForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int) -> Int
    {
        return defaults.integer(forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel))
    }
    //********************************************************************
    func setFloatForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int, vValue: Float)
    {
        defaults.set(vValue, forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel))
    }
    //********************************************************************
    func getFloatForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int) -> Float
    {
        return defaults.float(forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel)) 
    }
    //********************************************************************
    func setStringsForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int, vValue: [String])
    {
        defaults.set(vValue, forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel))
    }
    //********************************************************************
    func getStringsForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int) -> [String]
    {
        return defaults.stringArray(forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel)) ?? [String]()
    }
    //********************************************************************
    func removeForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int)
    {
        defaults.removeObject(forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel))
    }
    //********************************************************************
    func setBoolForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int, vOn: Bool)
    {
        if(vOn == true) { defaults.set("Y", forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel)) }
        else            { defaults.set("N", forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel)) }
    }
    //********************************************************************
    func getBoolForKey(vKey: menuButtonTypes, vMap: Int, vLevel: Int) -> Bool
    {
        guard let vKeyValue = defaults.string(forKey: getKeyDescription(vKey: vKey, vMap: vMap, vLevel: vLevel)), vKeyValue == "Y" else
        {
            //print("\(vKey) FALSE")
            return false
        }
        //print("\(vKey) TRUE")
        return true
    }
    //********************************************************************
    // DEBUG Routines
    //********************************************************************
    func DEBUGshowUserDefaults()
    {
        print("User Defaults *****************************************************")
        dump(Array(UserDefaults.standard.dictionaryRepresentation().keys))
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("User Defaults *****************************************************")
    }
    //********************************************************************
}

