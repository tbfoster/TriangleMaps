
import Foundation

//********************************************************************
class GameStateManager
{
    var data = Data.sharedInstance
    // Show game state in Console
    var debugState:             Bool = false
    
    // Helpers, so that stages can run at least once4
    var isNextWaveActive:       Bool = false
    var isMainMenuActive:       Bool = false
    var isEndGameActive:        Bool = false
    var isStagingActive:        Bool = false
    var isAddDefenseActive:     Bool = false
    var isUpgradeDefenseActive: Bool = false
    var isHelpActive:           Bool = false
    var isNewFeaturesActive:    Bool = false
    var isAnimationActive:      Bool = false
    
    //**********************************************************
    func selectMainMenu()
    {
        data.gameState = gameState.mainMenu
        isMainMenuActive = false
        displayState()
    }
    //**********************************************************
    func selectSubMenu()
    {
        data.gameState = gameState.subMenu
        displayState()
    }
    //**********************************************************
    func staging()
    {
        isStagingActive = false
        data.gameState = gameState.staging
        displayState()
    }
    //**********************************************************
    func run()
    {
        data.gameState = gameState.run
        displayState()
    }
    //**********************************************************
    func displayState()
    {
        if(debugState == true)
        {
            data.consoleMessage(vString: "Game State: \(data.gameState)")
        }
    }
}
