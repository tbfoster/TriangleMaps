import UIKit

//**************************************************************************
class MenuMain: MenuBaseClass
{
    weak var gameStateDelegate: mainMenuDelegate?
    var gameDefaults = Defaults()
    
    var btnNew   =  UIBarButtonItem(title: "New", style: .done, target: nil, action: nil)
    var btnLoad  = UIBarButtonItem(title: "Load", style: .done, target: nil, action: nil)
    var btnSolve  = UIBarButtonItem(title: "Solve", style: .done, target: nil, action: nil)
    
    var imageView = UIImageView()
    
    //**************************************************************************
    override func load(vGroup: Int, vView: UIView) {
        super.load(vGroup: vGroup, vView: vView)
        
        btnNew.target = self
        btnNew.action = #selector(handleNewGameButton(button:))
        btnLoad.target = self
        btnLoad.action = #selector(handleLoadGameButton(button:))
        btnSolve.target = self
        btnSolve.action = #selector(handleSolveGameButton(button:))
        btnSolve.title = "Solve \(data.isSolveOn)"
        
        imageView           = uid.addImage(vMenuType: .imageBackground, vImageName: data.getMenuImageName(vMenuButtonType: .imageCA9Background), vhasFrame: false)
        
        lblTitle.text = data.gameTitle
        
        updateDefaultColors()
        resize()
        hide()
    }
    //********************************************************************
    override func updateDefaultColors()
    {
        super.updateDefaultColors()
        
        imageView.image = data.getMenuImage(vMenuButtonType: .imageCA9Background)
    }
    //********************************************************************
    override func show() {
        super.show()
    }
    //********************************************************************
    override func resize() {
        super.resize()

        uid.align(vView: imageView,     horz: .center,  vert: .center,      widthPct: 1.0,  heightPct: 1.0,                      subX: nil,         subY: nil)
    }
    //**************************************************************************
    @objc func handleNewGameButton(button: UIBarButtonItem) {
        hide()
        gameStateDelegate?.mainMenuGenerateMap()
    }
    //**************************************************************************
    @objc func handleLoadGameButton(button: UIBarButtonItem) {
        hide()
        gameStateDelegate?.mainMenuSelectMap()
    }
    //**************************************************************************
    @objc func handleSolveGameButton(button: UIBarButtonItem) {
        hide()
        data.isSolveOn = !data.isSolveOn
        btnSolve.title = "Solve \(data.isSolveOn)"
        gameStateDelegate?.mainMenuSolveMap()
    }
    //**************************************************************************
}

