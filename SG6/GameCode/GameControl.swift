
import SceneKit
import Foundation
import GameplayKit
//import Crashlytics

//********************************************************************
// Main loop control for all game objects, tha big LOOP
//
// Pattern - GroundObjects are created for each wave
//           Set inactive on kill, remove array at the end of each wave
//********************************************************************
class GameControl
{
    static let sharedInstance = GameControl()
    
    var gNodes = GameNodes.sharedInstance
    var util = Util.sharedInstance
    var data = Data.sharedInstance
    var grid = Grid.sharedInstance
    var gameStats = GameStats.sharedInstance
    
    var gameDefaults = Defaults()
    
    weak var gameStateDelegate: gameControlDelegate?
    
    //********************************************************************
    func initGameControl()
    {
        
        
    }
    //********************************************************************
    func updateTime(vTime: TimeInterval)
    {
        if(data.isGamePaused == true) { return }
        data.FPSCount += 1
    }
    
    //********************************************************************
    func startNewGame(vLoadSavedGame: Bool)
    {
        gNodes.gameNodes.isHidden = false
        grid.clearGrid()
        grid.initGrid()
        if(data.isSolveOn == true)
        {
            let _ = grid.reloadGKGraph()
            grid.showPathNodes()
        }
    }
    //********************************************************************
    func selectPanel(vPanel: String)
    {
        grid.panelSelected = vPanel
        if(data.isSolveOn == true)
        {
            let _ = grid.reloadGKGraph()
        }
        let _ = grid.selectPanel()
        print(grid.panelSelected)
    }
    
    //********************************************************************
}
