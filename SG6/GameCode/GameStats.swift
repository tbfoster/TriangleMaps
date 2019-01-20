class GameStats
{
    static let sharedInstance = GameStats()
    
    private var activeCount:            [gameTypes:Int] = [.g1:0, .g2:0, .g3:0, .g4:0, .g5:0, .g6:0, .groundTotal:0, .highActive:0]
    private var waveKills:              [gameTypes:Int] = [.g1:0, .g2:0, .g3:0, .g4:0, .g5:0, .g6:0, .groundTotal:0]
    private var waveEscapes:            [gameTypes:Int] = [.g1:0, .g2:0, .g3:0, .g4:0, .g5:0, .g6:0, .groundTotal:0]  
    
    private var money:                  Int = 0             // Updated in GameControl.resetGame()
    private var groundActiveCount:      Int = 0             // Currant active count of ground troups
    private var gameTotalEscapes:       Int = 0             // Total escapes for current game
    private var gamePerfectWaveCount:   Int = 0             // Number of perfect waves, counter to offer warp
    
    private var lastWaveBonus:          Int = 0             // Used for saving end wave bonus amount to display on endWave and statistics
    private var lastWaveGroundKills:    Int = 0             // Used for storing endWave data for menuEndWave
    private var lastWaveEscapes:        Int = 0             // Used for storing endWave data for menuEndWave
    
    //********************************************************************
    func getActiveCount(vGameType: gameTypes) -> Int { return activeCount[vGameType]! }
    //********************************************************************
    func getGameTotalEscapes() -> Int { return gameTotalEscapes }
    //********************************************************************
    func setGameTotalEscapes(vCount: Int) { gameTotalEscapes = vCount }
    //********************************************************************
    func getEscapesForWave(vGameType: gameTypes) -> Int { return waveEscapes[vGameType]! }
    //********************************************************************
    func getTotalEscapesForWave() -> Int { return waveEscapes[.groundTotal]! }
    //********************************************************************
    func getLastWaveBonus() -> Int { return lastWaveBonus }
    //********************************************************************
    func getLastWaveGroundKills() -> Int { return lastWaveGroundKills }
    //********************************************************************
    func getLastWaveEscapes() -> Int { return lastWaveEscapes }
    //********************************************************************
    func getPerfectWaveCount() -> Int { return gamePerfectWaveCount }
    //********************************************************************
    func getMoney() -> Int { return money }
    //********************************************************************
    func getHighActiveCount() -> Int { return activeCount[.highActive]! }
    //********************************************************************
    func getTotalGroundKills() -> Int { return waveKills[.groundTotal]! }
    //********************************************************************
    func setPerfectWaveCount(vCount: Int) { gamePerfectWaveCount = vCount }
    //********************************************************************
    func setMoney(vMoney: Int) { money = vMoney }
    //********************************************************************
    func setHighActiveCount()
    {
        activeCount[.groundTotal] = groundActiveCount
        if(activeCount[.highActive]! < groundActiveCount)
        {
            activeCount[.highActive]! = groundActiveCount
        }
    }
    //********************************************************************
    func saveLastWaveStats()
    {
        lastWaveEscapes     = waveEscapes[.groundTotal]!
        lastWaveGroundKills = waveKills[.groundTotal]!
    }
    //********************************************************************
    func saveLastWaveBonus(vBonus: Int) { lastWaveBonus = vBonus }
    //********************************************************************
    func resetWaveStats()
    {
        resetWaveKills()
        resetEscapes()
        activeCount[.g1]! = 0
        activeCount[.g2]! = 0
        activeCount[.g3]! = 0
        activeCount[.g4]! = 0
        activeCount[.g5]! = 0
        activeCount[.g6]! = 0
        activeCount[.groundTotal]! = 0
        
        activeCount[.highActive]! = 0
    }
    //********************************************************************
    func resetGameStats()
    {
        resetWaveStats()
        gameTotalEscapes = 0
    }
    //********************************************************************
    func resetWaveKills()
    {
        for (vGameType, _) in waveKills
        {
            waveKills[vGameType]! = 0
        }
    }
    //********************************************************************
    func resetEscapes()
    {
        for (vGameType, _) in waveEscapes
        {
            waveEscapes[vGameType]! = 0
        }
    }
    //********************************************************************
    func addPerfectWaveCount() { gamePerfectWaveCount += 1 }
    //********************************************************************
    func addMoney(vMoney: Int) { money += vMoney }
    //********************************************************************
    func subtractMoney(vMoney: Int) { money -= vMoney }
    //********************************************************************
    func addActiveCount(vGameType: gameTypes)
    {
        activeCount[vGameType]! += 1
        activeCount[.groundTotal] = activeCount[.g1]! + activeCount[.g2]! + activeCount[.g3]! + activeCount[.g4]! + activeCount[.g5]!
        
        if(activeCount[.groundTotal]! > activeCount[.highActive]!)
        {
            activeCount[.highActive]! = activeCount[.groundTotal]!
        }
    }
    //********************************************************************
    func subtractActiveCount(vGameType: gameTypes)
    {
        activeCount[vGameType]! -= 1
        activeCount[.groundTotal] = activeCount[.g1]! + activeCount[.g2]! + activeCount[.g3]! + activeCount[.g4]! + activeCount[.g5]!
    }
    //********************************************************************
    func addGroundKill(vGameType: gameTypes)
    {
        waveKills[vGameType]! += 1
        waveKills[.groundTotal]! += 1
    }
    //********************************************************************
    func addEscape(vGameType: gameTypes)
    {
        waveEscapes[vGameType]! += 1
        waveEscapes[.groundTotal]! += 1
        gameTotalEscapes += 1
    }
    //********************************************************************
}

