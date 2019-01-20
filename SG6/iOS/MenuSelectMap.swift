import UIKit

//**************************************************************************
class MenuSelectMap: MenuMapBaseClass
{
    weak var gameStateDelegate: selectMapDelegate?

    //**************************************************************************
    override func load(vGroup: Int, vView: UIView) {
        super.load(vGroup: vGroup, vView: vView)
        
        btnBack.target = self
        btnBack.action = #selector(handleBackButton(button:))
        btnEasy.target = self
        btnEasy.action = #selector(handleSelectEasyButton(button:))
       
        updateDefaultColors()
        resize()
        hide()
    }
    //**************************************************************************
    @objc override func handleBackButton(button: UIBarButtonItem)
    {
        hide()
        gameStateDelegate?.selectMapCloses()
    }
    //**************************************************************************
    @objc func handleSelectEasyButton(button: UIBarButtonItem)
    {
        data.mapSelected = pageCtrl.currentPage
        data.gameLevel = 0
        hide()
        gameStateDelegate?.selectMap()
    }
    //**************************************************************************
}

