import UIKit

//**************************************************************************
class MenuMainGame: MenuBaseClass
{
    weak var gameStateDelegate: gameMenuDelegate?
    var grid = Grid.sharedInstance
    var gameStats = GameStats.sharedInstance
    var gameDefaults = Defaults()
    
    var btnBack =       UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    var btnDump =       UIBarButtonItem(title: "Dump", style: .done, target: nil, action: nil)
    var btnPhoto =       UIBarButtonItem(title: "Photo", style: .done, target: nil, action: nil)
    
    var btnNormal =     UIBarButtonItem(title: ".normal", style: .done, target: nil, action: nil)
    var btnEntry =      UIBarButtonItem(title: ".entry", style: .done, target: nil, action: nil)
    var btnExit =       UIBarButtonItem(title: ".exit", style: .done, target: nil, action: nil)
    var btnNone =       UIBarButtonItem(title: ".none", style: .done, target: nil, action: nil)
    //**************************************************************************
    override func load(vGroup: Int, vView: UIView) {
        super.load(vGroup: vGroup, vView: vView)
        
        btnBack.target = self
        btnBack.action = #selector(handleBackButton(button:))
        btnDump.target = self
        btnDump.action = #selector(handleDumpButton(button:))
        
        btnNormal.target = self
        btnEntry.target = self
        btnExit.target = self
        btnNone.target = self
        btnPhoto.target = self
        
        btnNormal.action = #selector(handleNormalButton(button:))
        btnEntry.action = #selector(handleEntryButton(button:))
        btnExit.action = #selector(handleExitButton(button:))
        btnNone.action = #selector(handleNoneButton(button:))
        btnPhoto.action = #selector(handlePhotoButton(button:))
        
        toolBar.items = [btnNormal, btnEntry, btnExit, btnNone]
        resize()
        hide()
    }
    //**************************************************************************
    func setPanel(vPanelType: panelTypes)
    {
        grid.gridPanels[grid.panelSelected]?.setType(vPanelType: vPanelType)
        grid.cancelCursor()
    }
    //**************************************************************************
    @objc func handleBackButton(button: UIBarButtonItem) {
        //Do Not Hude hide()
        gameStateDelegate?.gameMenuQuitsGame()
    }
    //**************************************************************************
    @objc func handleDumpButton(button: UIBarButtonItem) {
        //Do Not Hude hide()
        grid.DEBUGdumpArray()
        grid.DEBUGdumpMap()
    }
    //**************************************************************************
    @objc func handlePhotoButton(button: UIBarButtonItem) {
        toolBar.isHidden = true
        grid.showPhoto()
        gameStateDelegate?.gameMenuPhoto()
    }
    //**************************************************************************
    @objc func handleNormalButton(button: UIBarButtonItem) {
        setPanel(vPanelType: .normal)
    }
    //**************************************************************************
    @objc func handleEntryButton(button: UIBarButtonItem) {
        setPanel(vPanelType: .entry)
    }
    //**************************************************************************
    @objc func handleExitButton(button: UIBarButtonItem) {
        setPanel(vPanelType: .exit)
    }
    //**************************************************************************
    @objc func handleNoneButton(button: UIBarButtonItem) {
        setPanel(vPanelType: .none)
    }
    //**************************************************************************
}

