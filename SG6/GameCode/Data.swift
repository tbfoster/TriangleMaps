
import SceneKit
import GameplayKit
import Foundation
//********************************************************************
// Shared data class and master control variables
//********************************************************************
// - Search TODO - must fix
// - Search ACHIEVEMENTS
// - Search PERFORMANCE - options to increase performance if necessary
// - Search POINT_RELEASE - things to do before a version upgrade
// - Search GOLIVE - take out for production
// - Search TESTTHIS - this needs to be tested
// - Search INFO - specialty info
// - Search NOTUSED - hang on to it, may need it later
// - Search ERRORS - Errors that I can't seem to remove
// - Search GAME-LEVEL - adjustments for (easy...hard)
// - Search SIM or SIMULATOR - all simulator functions and variables
// - KEEP btnSelect.titleLabel?.lineBreakMode = .byWordWrapping
//********************************************************************
struct PRIME_MAPS
{
    var map: Int
    var level: Int
    var type: gameTypes
    var panel: String
}
//********************************************************************
struct ATTACK_DATA
{
    var lane: Int
    var speed: Float
    var points: Int
}
//********************************************************************
private var attackData: [gameTypes:ATTACK_DATA] =
    [ .g1:ATTACK_DATA(lane: 0, speed: 0.50,  points: 1),
      .g2:ATTACK_DATA(lane: 1, speed: 0.53,  points: 2),
      .g3:ATTACK_DATA(lane: 2, speed: 0.57,  points: 3),
      .g4:ATTACK_DATA(lane: 3, speed: 0.60,  points: 4),
      .g5:ATTACK_DATA(lane: 4, speed: 0.64,  points: 5),
      .g6:ATTACK_DATA(lane: 5, speed: 0.679, points: 6),
]
//********************************************************************
struct DEFENSE_DATA
{
    var name: String
    var cost: Int
    var damage: CGFloat
    var reload: CGFloat
    var nextUpgrade: gameTypes
    var upgradeLevel: CGFloat
    var displayLevel: Int
}
//********************************************************************
private var defenseData: [gameTypes:DEFENSE_DATA] =
    [   .d0: DEFENSE_DATA(name: "D0",       cost: 0,  damage: 0,     reload: 0,     nextUpgrade: .d0,   upgradeLevel: 0,   displayLevel: 0),
        .d1: DEFENSE_DATA(name: "D1",       cost: 50, damage: 0.725, reload: 0.36,  nextUpgrade: .d2,   upgradeLevel: 0.1, displayLevel: 1),
        .d2: DEFENSE_DATA(name: "D2",       cost: 50, damage: 0.725, reload: 0.36,  nextUpgrade: .d3,   upgradeLevel: 0.2, displayLevel: 2),
        .d3: DEFENSE_DATA(name: "D3",       cost: 50, damage: 0.84,  reload: 0.341, nextUpgrade: .d4,   upgradeLevel: 0.3, displayLevel: 3),
        .d4: DEFENSE_DATA(name: "D4",       cost: 50, damage: 0.966, reload: 0.323, nextUpgrade: .d5,   upgradeLevel: 0.4, displayLevel: 4),
        .d5: DEFENSE_DATA(name: "D5",       cost: 50, damage: 0.966, reload: 0.323, nextUpgrade: .d6,   upgradeLevel: 0.5, displayLevel: 5),
        .d6: DEFENSE_DATA(name: "D6",       cost: 50, damage: 1.113, reload: 0.306, nextUpgrade: .d7,   upgradeLevel: 0.6, displayLevel: 6),
        .d7: DEFENSE_DATA(name: "D7",       cost: 50, damage: 1.271, reload: 0.29,  nextUpgrade: .d8,   upgradeLevel: 0.7, displayLevel: 7),
        .d8: DEFENSE_DATA(name: "D8",       cost: 50, damage: 1.47,  reload: 0.274, nextUpgrade: .d9,   upgradeLevel: 0.8, displayLevel: 8),
        .d9: DEFENSE_DATA(name: "D9",       cost: 50, damage: 1.47,  reload: 0.274, nextUpgrade: .d10,  upgradeLevel: 0.9, displayLevel: 9),
        .d10:DEFENSE_DATA(name: "D10",      cost: 50, damage: 1.68,  reload: 0.274, nextUpgrade: .none, upgradeLevel: 1.0, displayLevel: 10),
        .none:DEFENSE_DATA(name: "DDONE",   cost: 50, damage: 1.68,  reload: 0.274, nextUpgrade: .none, upgradeLevel: 0.1, displayLevel: 0),
]
//********************************************************************
struct MAP_DATA
{
    var map: Int
    var start: Int
    var bonus: Int
    var escapes: Int
    var waves: Int
    var mapName: String
    var image: String
}
//********************************************************************
var mapData: [[MAP_DATA]] =
    [
        // TODO TEST ALL Maps for max costs and end wave settings
        [MAP_DATA(map: 1, start: 1000, bonus: 75, escapes: 1, waves: 21, mapName: "Training Map", image: "Map0.png"),// TODO escapes = 1
         MAP_DATA(map: 1, start: 1000, bonus: 75, escapes: 10, waves: 21, mapName: "Training Map", image: "Map0.png"),
         MAP_DATA(map: 1, start: 1000, bonus: 75, escapes: 2,  waves: 21, mapName: "Training Map", image: "Map0.png")], // TODO escapes = 1
        
        [MAP_DATA(map: 2, start: 1000, bonus: 75, escapes: 1, waves: 91, mapName: "Map1", image: "Map1.png"),// TODO escapes = 1
         MAP_DATA(map: 2, start: 1000, bonus: 75, escapes: 10, waves: 91, mapName: "Map1", image: "Map1.png"),
         MAP_DATA(map: 2, start: 1000, bonus: 75, escapes: 5,  waves: 91, mapName: "Map1", image: "Map1.png")],
        
        [MAP_DATA(map: 3, start: 1000, bonus: 95, escapes: 15, waves: 84, mapName: "Map2", image: "Map2.png"),
         MAP_DATA(map: 3, start: 1000, bonus: 95, escapes: 10, waves: 84, mapName: "Map2", image: "Map2.png"),
         MAP_DATA(map: 3, start: 1000, bonus: 95, escapes: 5,  waves: 84, mapName: "Map2", image: "Map2.png")],
        
        [MAP_DATA(map: 4, start: 1000, bonus: 60, escapes: 15, waves: 93, mapName: "Map3", image: "Map3.png"),
         MAP_DATA(map: 4, start: 1000, bonus: 60, escapes: 10, waves: 93, mapName: "Map3", image: "Map3.png"),
         MAP_DATA(map: 4, start: 1000, bonus: 60, escapes: 5,  waves: 93, mapName: "Map3", image: "Map3.png")],
        
        [MAP_DATA(map: 5, start: 1200, bonus: 60, escapes: 15, waves: 90, mapName: "Map4", image: "Map4.png"),
         MAP_DATA(map: 5, start: 1200, bonus: 60, escapes: 10, waves: 90, mapName: "Map4", image: "Map4.png"),
         MAP_DATA(map: 5, start: 1200, bonus: 60, escapes: 5,  waves: 90, mapName: "Map4", image: "Map4.png")],
        
        [MAP_DATA(map: 6, start: 1000, bonus: 50, escapes: 15, waves: 89, mapName: "Map5", image: "Map5.png"),
         MAP_DATA(map: 6, start: 1000, bonus: 50, escapes: 10, waves: 89, mapName: "Map5", image: "Map5.png"),
         MAP_DATA(map: 6, start: 1000, bonus: 50, escapes: 5,  waves: 89, mapName: "Map5", image: "Map5.png")],
        
        [MAP_DATA(map: 7, start: 1000, bonus: 50, escapes: 15, waves: 96, mapName: "Map6", image: "Map6.png"),
         MAP_DATA(map: 7, start: 1000, bonus: 50, escapes: 10, waves: 96, mapName: "Map6", image: "Map6.png"),
         MAP_DATA(map: 7, start: 1000, bonus: 50, escapes: 5,  waves: 96, mapName: "Map6", image: "Map6.png")],
        
        [MAP_DATA(map: 8, start: 1000, bonus: 50, escapes: 15, waves: 91, mapName: "Map7", image: "Map7.png"),
         MAP_DATA(map: 8, start: 1000, bonus: 50, escapes: 10, waves: 91, mapName: "Map7", image: "Map7.png"),
         MAP_DATA(map: 8, start: 1000, bonus: 50, escapes: 5,  waves: 91, mapName: "Map7", image: "Map7.png")],
        
        [MAP_DATA(map: 9, start: 1000, bonus: 75, escapes: 15, waves: 87, mapName: "Map8", image: "Map8.png"),
         MAP_DATA(map: 9, start: 1000, bonus: 75, escapes: 10, waves: 87, mapName: "Map8", image: "Map8.png"),
         MAP_DATA(map: 9, start: 1000, bonus: 75, escapes: 5,  waves: 87, mapName: "Map8", image: "Map8.png")],
        
        [MAP_DATA(map: 10, start: 1000, bonus: 50, escapes: 15, waves: 92, mapName: "Map9", image: "Map9.png"),
         MAP_DATA(map: 10, start: 1000, bonus: 50, escapes: 10, waves: 92, mapName: "Map9", image: "Map9.png"),
         MAP_DATA(map: 10, start: 1000, bonus: 50, escapes: 5,  waves: 92, mapName: "Map9", image: "Map9.png")],
        
        
]

//********************************************************************
struct MAP_DETAIL
{
    var name: String
    var type: panelTypes
    var pos: SCNVector3
    var conn: [String]
}
//********************************************************************
var mapXDetail: [MAP_DETAIL] = [
    MAP_DETAIL(name: "Panel:119", type: .normal, pos: SCNVector3(-8.00, 0.00, -6.60), conn: ["Panel:138", "Panel:139", ]),
    MAP_DETAIL(name: "Panel:142", type: .normal, pos: SCNVector3(0.00, 0.00, -4.40), conn: ["Panel:161", "Panel:123", "Panel:141", "Panel:143", "Panel:160", "Panel:162", ]),
    MAP_DETAIL(name: "Panel:125", type: .normal, pos: SCNVector3(4.00, 0.00, -6.60), conn: ["Panel:144", "Panel:143", "Panel:145", ]),
    MAP_DETAIL(name: "Panel:202", type: .normal, pos: SCNVector3(6.00, 0.00, 1.20), conn: ["Panel:221", "Panel:183", "Panel:203", "Panel:201", "Panel:182", "Panel:184", ]),
    MAP_DETAIL(name: "Panel:201", type: .normal, pos: SCNVector3(4.00, 0.00, 2.20), conn: ["Panel:220", "Panel:182", "Panel:200", "Panel:202", "Panel:219", "Panel:221", ]),
    MAP_DETAIL(name: "Panel:145", type: .normal, pos: SCNVector3(6.00, 0.00, -5.40), conn: ["Panel:164", "Panel:146", "Panel:144", "Panel:125", "Panel:127", ]),
    MAP_DETAIL(name: "Panel:179", type: .normal, pos: SCNVector3(-2.00, 0.00, -1.00), conn: ["Panel:198", "Panel:160", "Panel:180", "Panel:178", "Panel:159", "Panel:161", ]),
    MAP_DETAIL(name: "Panel:160", type: .normal, pos: SCNVector3(-2.00, 0.00, -3.20), conn: ["Panel:179", "Panel:141", "Panel:161", "Panel:159", "Panel:140", "Panel:142", ]),
    MAP_DETAIL(name: "Panel:177", type: .normal, pos: SCNVector3(-6.00, 0.00, -1.00), conn: ["Panel:196", "Panel:158", "Panel:178", "Panel:176", "Panel:157", "Panel:159", ]),
    MAP_DETAIL(name: "Panel:163", type: .normal, pos: SCNVector3(4.00, 0.00, -2.20), conn: ["Panel:182", "Panel:144", "Panel:162", "Panel:164", "Panel:181", "Panel:183", ]),
    MAP_DETAIL(name: "Panel:216", type: .normal, pos: SCNVector3(-4.00, 0.00, 4.40), conn: ["Panel:197", "Panel:215", "Panel:217", ]),
    MAP_DETAIL(name: "Panel:164", type: .normal, pos: SCNVector3(6.00, 0.00, -3.20), conn: ["Panel:183", "Panel:145", "Panel:165", "Panel:163", "Panel:144", "Panel:146", ]),
    MAP_DETAIL(name: "Panel:180", type: .normal, pos: SCNVector3(0.00, 0.00, -0.00), conn: ["Panel:199", "Panel:161", "Panel:179", "Panel:181", "Panel:198", "Panel:200", ]),
    MAP_DETAIL(name: "Panel:200", type: .normal, pos: SCNVector3(2.00, 0.00, 1.20), conn: ["Panel:219", "Panel:181", "Panel:201", "Panel:199", "Panel:180", "Panel:182", ]),
    MAP_DETAIL(name: "Panel:127", type: .entry, pos: SCNVector3(8.00, 0.00, -6.60), conn: ["Panel:146", "Panel:145", ]),
    MAP_DETAIL(name: "Panel:181", type: .normal, pos: SCNVector3(2.00, 0.00, -1.00), conn: ["Panel:200", "Panel:162", "Panel:182", "Panel:180", "Panel:161", "Panel:163", ]),
    MAP_DETAIL(name: "Panel:183", type: .normal, pos: SCNVector3(6.00, 0.00, -1.00), conn: ["Panel:202", "Panel:164", "Panel:184", "Panel:182", "Panel:163", "Panel:165", ]),
    MAP_DETAIL(name: "Panel:178", type: .normal, pos: SCNVector3(-4.00, 0.00, -0.00), conn: ["Panel:197", "Panel:159", "Panel:177", "Panel:179", "Panel:196", "Panel:198", ]),
    MAP_DETAIL(name: "Panel:140", type: .normal, pos: SCNVector3(-4.00, 0.00, -4.40), conn: ["Panel:159", "Panel:121", "Panel:139", "Panel:141", "Panel:158", "Panel:160", ]),
    MAP_DETAIL(name: "Panel:197", type: .normal, pos: SCNVector3(-4.00, 0.00, 2.20), conn: ["Panel:216", "Panel:178", "Panel:196", "Panel:198", "Panel:215", "Panel:217", ]),
    MAP_DETAIL(name: "Panel:203", type: .normal, pos: SCNVector3(8.00, 0.00, 2.20), conn: ["Panel:222", "Panel:184", "Panel:202", "Panel:221", ]),
    MAP_DETAIL(name: "Panel:215", type: .normal, pos: SCNVector3(-6.00, 0.00, 3.40), conn: ["Panel:196", "Panel:216", "Panel:214", "Panel:195", "Panel:197", ]),
    MAP_DETAIL(name: "Panel:141", type: .normal, pos: SCNVector3(-2.00, 0.00, -5.40), conn: ["Panel:160", "Panel:142", "Panel:140", "Panel:121", "Panel:123", ]),
    MAP_DETAIL(name: "Panel:214", type: .normal, pos: SCNVector3(-8.00, 0.00, 4.40), conn: ["Panel:195", "Panel:215", ]),
    MAP_DETAIL(name: "Panel:219", type: .normal, pos: SCNVector3(2.00, 0.00, 3.40), conn: ["Panel:200", "Panel:220", "Panel:218", "Panel:199", "Panel:201", ]),
    MAP_DETAIL(name: "Panel:165", type: .normal, pos: SCNVector3(8.00, 0.00, -2.20), conn: ["Panel:184", "Panel:146", "Panel:164", "Panel:183", ]),
    MAP_DETAIL(name: "Panel:157", type: .normal, pos: SCNVector3(-8.00, 0.00, -2.20), conn: ["Panel:176", "Panel:138", "Panel:158", "Panel:177", ]),
    MAP_DETAIL(name: "Panel:162", type: .normal, pos: SCNVector3(2.00, 0.00, -3.20), conn: ["Panel:181", "Panel:143", "Panel:163", "Panel:161", "Panel:142", "Panel:144", ]),
    MAP_DETAIL(name: "Panel:218", type: .normal, pos: SCNVector3(0.00, 0.00, 4.40), conn: ["Panel:199", "Panel:217", "Panel:219", ]),
    MAP_DETAIL(name: "Panel:121", type: .normal, pos: SCNVector3(-4.00, 0.00, -6.60), conn: ["Panel:140", "Panel:139", "Panel:141", ]),
    MAP_DETAIL(name: "Panel:139", type: .normal, pos: SCNVector3(-6.00, 0.00, -5.40), conn: ["Panel:158", "Panel:140", "Panel:138", "Panel:119", "Panel:121", ]),
    MAP_DETAIL(name: "Panel:184", type: .normal, pos: SCNVector3(8.00, 0.00, -0.00), conn: ["Panel:203", "Panel:165", "Panel:183", "Panel:202", ]),
    MAP_DETAIL(name: "Panel:221", type: .normal, pos: SCNVector3(6.00, 0.00, 3.40), conn: ["Panel:202", "Panel:222", "Panel:220", "Panel:201", "Panel:203", ]),
    MAP_DETAIL(name: "Panel:158", type: .normal, pos: SCNVector3(-6.00, 0.00, -3.20), conn: ["Panel:177", "Panel:139", "Panel:159", "Panel:157", "Panel:138", "Panel:140", ]),
    MAP_DETAIL(name: "Panel:143", type: .normal, pos: SCNVector3(2.00, 0.00, -5.40), conn: ["Panel:162", "Panel:144", "Panel:142", "Panel:123", "Panel:125", ]),
    MAP_DETAIL(name: "Panel:159", type: .normal, pos: SCNVector3(-4.00, 0.00, -2.20), conn: ["Panel:178", "Panel:140", "Panel:158", "Panel:160", "Panel:177", "Panel:179", ]),
    MAP_DETAIL(name: "Panel:182", type: .normal, pos: SCNVector3(4.00, 0.00, -0.00), conn: ["Panel:201", "Panel:163", "Panel:181", "Panel:183", "Panel:200", "Panel:202", ]),
    MAP_DETAIL(name: "Panel:196", type: .normal, pos: SCNVector3(-6.00, 0.00, 1.20), conn: ["Panel:215", "Panel:177", "Panel:197", "Panel:195", "Panel:176", "Panel:178", ]),
    MAP_DETAIL(name: "Panel:220", type: .normal, pos: SCNVector3(4.00, 0.00, 4.40), conn: ["Panel:201", "Panel:219", "Panel:221", ]),
    MAP_DETAIL(name: "Panel:199", type: .normal, pos: SCNVector3(0.00, 0.00, 2.20), conn: ["Panel:218", "Panel:180", "Panel:198", "Panel:200", "Panel:217", "Panel:219", ]),
    MAP_DETAIL(name: "Panel:144", type: .normal, pos: SCNVector3(4.00, 0.00, -4.40), conn: ["Panel:163", "Panel:125", "Panel:143", "Panel:145", "Panel:162", "Panel:164", ]),
    MAP_DETAIL(name: "Panel:176", type: .normal, pos: SCNVector3(-8.00, 0.00, -0.00), conn: ["Panel:195", "Panel:157", "Panel:177", "Panel:196", ]),
    MAP_DETAIL(name: "Panel:195", type: .normal, pos: SCNVector3(-8.00, 0.00, 2.20), conn: ["Panel:214", "Panel:176", "Panel:196", "Panel:215", ]),
    MAP_DETAIL(name: "Panel:198", type: .normal, pos: SCNVector3(-2.00, 0.00, 1.20), conn: ["Panel:217", "Panel:179", "Panel:199", "Panel:197", "Panel:178", "Panel:180", ]),
    MAP_DETAIL(name: "Panel:146", type: .normal, pos: SCNVector3(8.00, 0.00, -4.40), conn: ["Panel:165", "Panel:127", "Panel:145", "Panel:164", ]),
    MAP_DETAIL(name: "Panel:138", type: .normal, pos: SCNVector3(-8.00, 0.00, -4.40), conn: ["Panel:157", "Panel:119", "Panel:139", "Panel:158", ]),
    MAP_DETAIL(name: "Panel:161", type: .normal, pos: SCNVector3(0.00, 0.00, -2.20), conn: ["Panel:180", "Panel:142", "Panel:160", "Panel:162", "Panel:179", "Panel:181", ]),
    MAP_DETAIL(name: "Panel:123", type: .normal, pos: SCNVector3(0.00, 0.00, -6.60), conn: ["Panel:142", "Panel:141", "Panel:143", ]),
    MAP_DETAIL(name: "Panel:217", type: .normal, pos: SCNVector3(-2.00, 0.00, 3.40), conn: ["Panel:198", "Panel:218", "Panel:216", "Panel:197", "Panel:199", ]),
    MAP_DETAIL(name: "Panel:222", type: .exit, pos: SCNVector3(8.00, 0.00, 4.40), conn: ["Panel:203", "Panel:221", ]),
]


//********************************************************************
struct TEXTURE
{
    var name: String
    var color: UIColor
}
//********************************************************************
//gameTypeTextures on getTheme - use directory
var gameTextures: [[gameTextureTypes:TEXTURE]] =
[ [     // Theme Zero ****************************************************************************************************************************
        .g1:                    TEXTURE(name: "G1.png", color: UIColor.clear),
        .g2:                    TEXTURE(name: "G2.png", color: UIColor.clear),
        .g3:                    TEXTURE(name: "G3.png", color: UIColor.clear),
        .g4:                    TEXTURE(name: "G4.png", color: UIColor.clear),
        .g5:                    TEXTURE(name: "G5.png", color: UIColor.clear),
        .g6:                    TEXTURE(name: "G6.png", color: UIColor.clear),
        .d0:                    TEXTURE(name: "D0.png", color: UIColor.clear),
        .d1:                    TEXTURE(name: "D1.png", color: UIColor.clear),
        .d2:                    TEXTURE(name: "D2.png", color: UIColor.clear),
        .d3:                    TEXTURE(name: "D3.png", color: UIColor.clear),
        .d4:                    TEXTURE(name: "D4.png", color: UIColor.clear),
        .d5:                    TEXTURE(name: "D5.png", color: UIColor.clear),
        .d6:                    TEXTURE(name: "D6.png", color: UIColor.clear),
        .d7:                    TEXTURE(name: "D7.png", color: UIColor.clear),
        .d8:                    TEXTURE(name: "D8.png", color: UIColor.clear),
        .d9:                    TEXTURE(name: "D9.png", color: UIColor.clear),
        .d10:                   TEXTURE(name: "D10.png", color: UIColor.clear),
        .defenseBase:           TEXTURE(name: "DefenseBase.png",        color: UIColor.clear),
        .themeRiserBtn:         TEXTURE(name: "BtnAddRiser.png",        color: UIColor.clear),
        .themeAddDefenseBtn:    TEXTURE(name: "BtnAddDefense.png",      color: UIColor.clear),
        .themeUpgradeDefenseBtn:TEXTURE(name: "BtnUpgradeDefense.png",  color: UIColor.clear),
        .themeEnemies:          TEXTURE(name: "BtnEnemyTheme.png",      color: UIColor.clear),
        
        .g1ExplosionColor:      TEXTURE(name: "", color: UIColor.yellow),
        .g2ExplosionColor:      TEXTURE(name: "", color: UIColor.blue),
        .g3ExplosionColor:      TEXTURE(name: "", color: UIColor.red),
        .g4ExplosionColor:      TEXTURE(name: "", color: UIColor.purple),
        .g5ExplosionColor:      TEXTURE(name: "", color: UIColor.orange),
        .g6ExplosionColor:      TEXTURE(name: "", color: UIColor.green),
        
        .d1ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 1.0,   blue: 1.0, alpha: 1)),
        .d2ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.9,   blue: 0.9, alpha: 1)),
        .d3ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.8,   blue: 0.8, alpha: 1)),
        .d4ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.7,   blue: 0.7, alpha: 1)),
        .d5ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.6,   blue: 0.6, alpha: 1)),
        .d6ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.5,   blue: 0.5, alpha: 1)),
        .d7ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.4,   blue: 0.4, alpha: 1)),
        .d8ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.3,   blue: 0.3, alpha: 1)),
        .d9ProjectileColor:     TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.2,   blue: 0.2, alpha: 1)),
        .d10ProjectileColor:    TEXTURE(name: "", color: UIColor(displayP3Red: 1.0,   green: 0.0,   blue: 0.0, alpha: 1)),
        .barrelColor:           TEXTURE(name: "", color: UIColor(displayP3Red: 1,     green: 0,     blue: 0,   alpha: 1)),
        ],
    // Theme Two (may have different explosion colors) ********************************************************************************************
    [
        .g1ExplosionColor:      TEXTURE(name: "", color: UIColor.darkGray),
        .g2ExplosionColor:      TEXTURE(name: "", color: UIColor.yellow),
        .g3ExplosionColor:      TEXTURE(name: "", color: UIColor(displayP3Red: 37/255, green: 72/255, blue: 150/255, alpha: 1)),
        .g4ExplosionColor:      TEXTURE(name: "", color: UIColor(displayP3Red: 120/255, green: 197/255, blue: 240/255, alpha: 1)),
        .g5ExplosionColor:      TEXTURE(name: "", color: UIColor.magenta),
        .g6ExplosionColor:      TEXTURE(name: "", color: UIColor.red),
        .barrelColor:           TEXTURE(name: "", color: UIColor(displayP3Red: 1,     green: 0,     blue: 0,   alpha: 1)),
        ]
]
//********************************************************************
struct DEFAULT_COLORS
{
    var custom: Bool
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}
//********************************************************************
var defaultColors: [menuButtonTypes:DEFAULT_COLORS] =
    [   .keyInfoTextColor:          DEFAULT_COLORS(custom: true, red: 1.000,green: 1.000,blue: 1.000, alpha: 1),
]
//********************************************************************
var colors: [menuButtonTypes:DEFAULT_COLORS] =
    [   .keyInfoTextColor:          DEFAULT_COLORS(custom: true, red: 1.000,green: 1.000,blue: 1.000, alpha: 1),
]
//********************************************************************
struct UITextImage
{
    var points: CGFloat
    var text: String
    var image: String
}
//********************************************************************
private var uiTextImages: [menuButtonTypes:UITextImage] =
    [   .keyEasyPlayed:         UITextImage(points: 0.05, text: "Play 1 Easy Level", image: ""),
        .keyEasyWon:            UITextImage(points: 0.05, text: "Win Easy Level", image: ""),
        .keyEasyNoEscapes:      UITextImage(points: 0.05, text: "Win Easy Level With No Escapes", image: ""),
        
        .keyMidPlayed:          UITextImage(points: 0.05, text: "Play 1 Mid Level", image: ""),
        .keyMidWin:             UITextImage(points: 0.05, text: "Win Mid Level", image: ""),
        .keyMidNoEscapes:       UITextImage(points: 0.05, text: "Win Mid Level With No Escapes", image: ""),
        
        .keyHardPlayed:         UITextImage(points: 0.05, text: "Play 1 Hard Level", image: ""),
        .keyHardWin:            UITextImage(points: 0.05, text: "Win Hard Level", image: ""),
        .keyHardNoEscapes:      UITextImage(points: 0.05, text: "Win Hard Level With No Escapes", image: ""),
        
        .keyWarpToVictory:      UITextImage(points: 0.05, text: "Warp To Victory on Hard Level", image: ""),
        
        .keyBuyNoAds:           UITextImage( points: 0.00, text: "No Adds Or Videos", image: ""),
        .keyBuyNewMaps:         UITextImage( points: 0.00, text: "Unlock Hidden Maps", image: ""),
        .keyBuyAll:             UITextImage( points: 0.00, text: "Just Max Out Everything", image: ""),
        
        .infoAddDefense:        UITextImage(points: 0.00, text: "Add defense for $ 50", image: ""),
        .infoUpgradeDefense:    UITextImage(points: 0.00, text: "Upgrade defense for $ 50", image: ""),
        .infoNoFunding:         UITextImage(points: 0.00, text: "No Funding for Defense", image: ""),
        .infoDefensesMaxed:     UITextImage(points: 0.00, text: "Defense is maximized.", image: ""),
        .infoNoInventory:       UITextImage(points: 0.00, text: "Inventory Depleted", image: ""),
        
        .btnNewGame:            UITextImage(points: 0.00, text: "New Game", image: ""),
        .btnSavedGame:          UITextImage(points: 0.00, text: "Saved Games", image: ""),
        .btnHighScores:         UITextImage(points: 0.00, text: "High Scores", image: ""),
        .btnSkins:              UITextImage(points: 0.00, text: "Skins", image: ""),
        .btnPlayer:             UITextImage(points: 0.00, text: "Player Experience", image: ""),
        .btnHelp:               UITextImage(points: 0.00, text: "Help - TEST Reset Achievements", image: ""),
        
        .imageCA9MktAdd:        UITextImage(points: 0.00, text: "", image: "Adca9creative.png"),
        .imageCA9Background:    UITextImage(points: 0.00, text: "", image: "AdGameLogo.jpeg"),
        
        .btnHudMenu:            UITextImage(points: 0.00, text: "", image: "BtnGameMenu.png"),
        .btnBack:               UITextImage(points: 0.00, text: "", image: "BtnBack.png"),
        .btnHome:               UITextImage(points: 0.00, text: "", image: "BtnHome.png"),
        .btnNext:               UITextImage(points: 0.00, text: "", image: "BtnNext.png"),
        .btnPrev:               UITextImage(points: 0.00, text: "", image: "BtnPrev.png"),
        .btnWarp:               UITextImage(points: 0.00, text: "", image: "BtnWarp.png"),
        .btnRemove:             UITextImage(points: 0.00, text: "", image: "BtnRemove.png"),
        .btnZoomIn:             UITextImage(points: 0.00, text: "", image: "BtnZoomIn.png"),
        .btnZoomOut:            UITextImage(points: 0.00, text: "", image: "BtnZoomOut.png"),
        .btnAddDefense:         UITextImage(points: 0.00, text: "", image: ""),
        .btnUpgradeDefense:     UITextImage(points: 0.00, text: "", image: ""),
        .btnRiser:              UITextImage(points: 0.00, text: "", image: "R"),
        .btnEasy:               UITextImage(points: 0.00, text: "", image: "BtnEasy.png"),
        .btnEasyNA:             UITextImage(points: 0.00, text: "", image: ""),
        .btnMid:                UITextImage(points: 0.00, text: "", image: "BtnMid.png"),
        .btnMidNA:              UITextImage(points: 0.00, text: "", image: ""),
        .btnHard:               UITextImage(points: 0.00, text: "", image: "BtnHard.png"),
        .btnHardNA:             UITextImage(points: 0.00, text: "", image: ""),
        .btnDefaults:           UITextImage(points: 0.00, text: "", image: "BtnDefaults.png"),
        .btnPhotos:             UITextImage(points: 0.00, text: "", image: "Photos.png"),
        .btnGotIt:              UITextImage(points: 0.00, text: "", image: "BtnGotIt.png"),
        .btnKeepShowing:        UITextImage(points: 0.00, text: "", image: "BtnKeepShowingThis.png"),
        .btnNoAds:              UITextImage(points: 0.00, text: "", image: "BtnBuyNoAds.png"),
        .btnBuyMaps:            UITextImage(points: 0.00, text: "", image: "BtnBuyMaps.png"),
        .btnBuyAll:             UITextImage(points: 0.00, text: "", image: "BtnBuyAll.png"),
        
        .btnAutoResumeOn:       UITextImage(points: 0.00, text: "", image: "BtnAutoResumeOn.png"),
        .btnAutoResumeOff:      UITextImage(points: 0.00, text: "", image: "BtnAutoResumeOff.png"),
        .btnAutoUpgradeOn:      UITextImage(points: 0.00, text: "", image: "BtnAutoUpgradeOn.png"),
        .btnAutoUpgradeOff:     UITextImage(points: 0.00, text: "", image: "BtnAutoUpgradeOff.png"),
        
        .sliderRed:             UITextImage(points: 0.00, text: "", image: ""),
        .sliderGreen:           UITextImage(points: 0.00, text: "", image: ""),
        .sliderBlue:            UITextImage(points: 0.00, text: "", image: ""),
        // Skins
        .btnEnemySkin1:         UITextImage(points: 0.00, text: "", image: "ThemePoolBalls.png"),
        .btnEnemySkin2:         UITextImage(points: 0.00, text: "", image: "ThemeDiscoBalls.png"),
        .btnDefenseSkin1:       UITextImage(points: 0.00, text: "", image: "DefenseButton.png"),
        .btnDefenseSkin2:       UITextImage(points: 0.00, text: "", image: "DefenseButtonTheme2.png"),
        .btnClock1:             UITextImage(points: 0.00, text: "", image: "Clock1.png"),
        .btnClock2:             UITextImage(points: 0.00, text: "", image: "Clock2.png"),
        .btnClock3:             UITextImage(points: 0.00, text: "", image: "Clock3.png"),
        .btnClock4:             UITextImage(points: 0.00, text: "", image: "Clock4.png"),
        .btnClock5:             UITextImage(points: 0.00, text: "", image: "Clock5.png"),
]
//********************************************************************
class Data
{
    static let sharedInstance = Data()
    var util = Util.sharedInstance
    var gameStats = GameStats.sharedInstance
    
    var gameDefaults = Defaults()
    
    let gameTitle = "Joseph has to name it :)"
    
    var IS_PRODUCTION_ON: Bool = false
    var DUMP_GAME_STATS: Bool = true
    
    var spriteNodes: [SKNode] = []
    
    
    // Attack Wave Data - Start wave times and counts for each wave, by game type
    let attackObjectStartTime:              [gameTypes: Int]       = [.g1:5, .g2:7, .g3:9,  .g4:11, .g5:15, .g6:19]
    let attackObjectStartWave:              [gameTypes: Int]       = [.g1:1, .g2:5, .g3:10, .g4:15, .g5:30, .g6:35]
    
    // All base count and max values
    let attackObjectBaseStart:              [gameTypes: Float]    = [.g1:4.55, .g2:0.65, .g3:0.8, .g4:0.85, .g5:0.9, .g6:0.95]
    let attackObjectMaxStart:               [gameTypes: Float]    = [.g1:0.85, .g2:0.65, .g3:0.8, .g4:0.85, .g5:0.9, .g6:0.95]
    
    // This is the amount to increase counts and max by wave
    let attackObjectBaseIncrease:           [gameTypes: Float]    = [.g1:0.45, .g2:0.35, .g3:0.2, .g4:0.15,  .g5:0.1,  .g6:0.05]
    let attackObjectMaxIncrease:            [gameTypes: Float]    = [.g1:0.15, .g2:0.10, .g3:0.08, .g4:0.06, .g5:0.04, .g6:0.03]
    
    // Attack Wave Vars
    var attackWaves:                        [Int: AttackWaveObject] = [:]
    var attackWaveObjectDone:               [gameTypes: Bool] = [.g1:false, .g2:false, .g3:false, .g4:false, .g5:false, .g6:false]
    var startWaveTime:                      [gameTypes: Int] = [:]
    var attackWaveCount:                    [gameTypes: Int] = [:]  // How many objects have been released
    var startWaveTimeOffset:                [gameTypes: Int] = [:]  // After release, reset startWaveTime to current plus N
    
    var gameState:                          gameState = .mainMenu
    
    // View Controller Shared Variables, Strafe, Select Nodes
    var frameSize =                         CGRect(x: 0, y: 0, width: 10, height: 10)   // Store frame size for resizing all windows and buttons
    var lastMouseX:                         Float = 0                                   // Keep last clicks or taps, shared with other classes
    var lastMouseY:                         Float = 0                                   // ...
    // Global Constraints - portrait has been disabled
    var font =                              UIFont.init(name: "GurmukhiMN", size: 26)!
    var menuFont = UIFont()
    var screenWidth:                        CGFloat = 0
    var screenHeight:                       CGFloat = 0
    var portraitScreenWidth:                CGFloat = 0
    var portraitScreenHeight:               CGFloat = 0
    var landscapeScreenWidth:               CGFloat = 0
    var landscapeScreenHeight:              CGFloat = 0
    var isLandscape:                        Bool = true
    var landscapeConstraints:               [NSLayoutConstraint] = []
    var portraitConstraints:                [NSLayoutConstraint] = []
    
    // Master Switches and Counters
    var isSolveOn:                          Bool = false        // GKGraph solve map is on/off
    var isGameTimerOn:                      Bool = false        // Are game timers on
    var isLoadingSavedGame:                 Bool = false        // if loading save games, some animiations can't run
    var isWarpSelected:                     Bool = false        // if warp is selected from menu, process
    var isGameAcceptingUserInput:           Bool = false        // If game is changing states, turn off user activity to avoid sync problems with state and menus
    var isGamePaused:                       Bool = true         // Game is paused - HUD activated pauses game
    var isResettingMovesOnNextUpdate:       Bool = false        // Defense was killed during loops, game needs to realoaded groundAttackMoves()
    var isGameActive:                       Bool = false        // If game is active, for AppDelegate
    var isAutoUpgradeOn:                    Bool = true         // If auto upgrade, touch it and it tried to upgrade based on funding
    var isAutoResumeOn:                     Bool = false        // If auto, end wave waits for user action
    var isAnimationOn:                      Bool = false        // End game animation
    var isIGotIt:                           Bool = false        // Help Screens 
    var defenseTypeSelectedFromPanel:       gameTypes = .d3     // The defense as selected by user from the panel (.none = add, .defense = upgrade
    var defenseIndexSelectedFromPanel:      Int = 0             // As panel is selected, save the index so we can test if it has not been killed
    
    var closestExit:                        Int = 50            // Closest groundObject has come to the exit panel
    var mapSelected:                        Int = 0             // Current map selected from menus or SIMautoLoad
    var savedGameWave:                      Int = 0             // The wave that loadSavedGame will use
    var waveTime:                           Int = 0             // Wave Time
    var currentWave:                        Int = 0             // Current Wave
    var gameLevel:                          Int = 0             // Game Level
    var maxDefenses:                        Int = 35            // Max defenses that can be used on any map
    
    var SNDphasersFiring:                   Int = 0             // Count of all phasers currently firing, so we can play some sounds, but not all
    
    var mapSettings:                        [Int:GameSettings] = [:]    // Game level settings index
    // DEBUG
    var FPSCount:                           Int = 0
    var FPSArray:                           [Int] = [60]      // Count FPS per frame for Answers average FPS
    // Player
    var minPlayerLevel:                     CGFloat = 0.50
    var playerLevel:                        CGFloat = 0.50
    // Skins
    var attackTheme:                        Int = 0
    var defenseTheme:                       Int = 0
    //********************************************************************
    init()
    {
        for vLoop in 0...18
        {
            let vMapSettings = GameSettings()
            mapSettings[vLoop] = vMapSettings
        }
    }
    //***************************************data.getMenuThemeImage(vGameType: .themeAddDefenseButton)*******************
    // Menu Data ex:"art.scnassets/Images/ca9creative.png"
    func getMenuImage(vMenuButtonType: menuButtonTypes) -> UIImage {
        let image = UIImage(named: "art.scnassets/Images/MenuButtons/" + uiTextImages[vMenuButtonType]!.image)
        return image!
    }
    //**********************************************************
    func getMenuImageName(vMenuButtonType: menuButtonTypes) -> String { return "art.scnassets/Images/" + uiTextImages[vMenuButtonType]!.image }
    //**********************************************************
    func getMenuText(vMenuButtonType: menuButtonTypes) -> String { return uiTextImages[vMenuButtonType]!.text }
    //**********************************************************
    // Map Data
    //**********************************************************
    func getMapName() -> String { return mapData[mapSelected][gameLevel].mapName }
    //**********************************************************
    func getMapImageName() -> String { return "art.scnassets/Images/Maps/" + mapData[mapSelected][gameLevel].image  }
    // Convert from game types to texture types
    func getTextureType(vGameType: gameTypes) -> gameTextureTypes
    {
        switch vGameType
        {
        case .g1: return .g1
        case .g2: return .g2
        case .g3: return .g3
        case .g4: return .g4
        case .g5: return .g5
        case .g6: return .g6
            
        case .d0: return .d0
        case .d1: return .d1
        case .d2: return .d2
        case .d3: return .d3
        case .d4: return .d4
        case .d5: return .d5
        case .d6: return .d6
        case .d7: return .d7
        case .d8: return .d8
        case .d9: return .d9
        case .d10: return .d10
        default:
            return .d0
        }
    }
    //**********************************************************
    //"art.scnassets/Images/ATheme0/G1.png",
    func getTextureImage(vTheme: Int, vTextureType: gameTextureTypes) -> UIImage
    {
        let vImageName = getTextureName(vTheme: vTheme, vTextureType: vTextureType)
        let image = UIImage(named: vImageName)
        return image!
    }
    //**********************************************************
    func getTextureName(vTheme: Int, vTextureType: gameTextureTypes) -> String
    {
        var vName: String = ""
        switch vTheme {
        case 0: vName = "art.scnassets/Images/ATheme0/" + gameTextures[0][vTextureType]!.name; break
        case 1: vName = "art.scnassets/Images/ATheme1/" + gameTextures[0][vTextureType]!.name; break
        case 2: vName = "art.scnassets/Images/ATheme2/" + gameTextures[0][vTextureType]!.name; break
        default:
            break
        }
        return (vName)
    }
    //********************************************************************
    // Theme is hardcoded to 0
    func getProjectileColor(vTheme: Int, vGameType: gameTypes) -> [SCNMaterial]
    {
        var vTextureType: gameTextureTypes = .d1
        switch vGameType
        {
        case .d1: vTextureType = .d1ProjectileColor; break
        case .d2: vTextureType = .d2ProjectileColor; break
        case .d3: vTextureType = .d3ProjectileColor; break
        case .d4: vTextureType = .d4ProjectileColor; break
        case .d5: vTextureType = .d5ProjectileColor; break
        case .d6: vTextureType = .d6ProjectileColor; break
        case .d7: vTextureType = .d7ProjectileColor; break
        case .d8: vTextureType = .d8ProjectileColor; break
        case .d9: vTextureType = .d9ProjectileColor; break
        case .d10: vTextureType = .d10ProjectileColor; break
        default:
            break
        }
        let mat = SCNMaterial()
        mat.diffuse.contents = gameTextures[0][vTextureType]!.color
        return [mat]
    }
    //**********************************************************
    func getTextureColor(vTheme: Int, vTextureType: gameTextureTypes) -> UIColor
    {
        return gameTextures[vTheme][vTextureType]!.color
    }
    //********************************************************************
    func consoleMessage(vString: String)
    {
        if(IS_PRODUCTION_ON == true) { return }
        print(vString)
    }
    //********************************************************************
}

