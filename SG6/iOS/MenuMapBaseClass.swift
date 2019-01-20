import UIKit

//**************************************************************************
class MenuMapBaseClass
{
    var group: Int = 0
    var uid = UIDesigner()
    var view = UIView()
    
    var data    = Data.sharedInstance
    
    var lblTitle = ThemeLbl(vMenuType: .lblTitle)
    
    var btnBack = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
    var btnEasy = UIBarButtonItem(title: "Easy", style: .done, target: nil, action: nil)
    var btnNorm = UIBarButtonItem(title: "Mid", style: .done, target: nil, action: nil)
    var btnHard = UIBarButtonItem(title: "Hard", style: .done, target: nil, action: nil)
    
    var imageView = UIImageView()
    
    var pageCtrl = UIPageControl()
    //var toolBar = GameToolBar(frame: .zero)
    
    //**************************************************************************
    func load(vGroup: Int, vView: UIView)
    {
        if(uid.DEBUG) { print("Group: \(vGroup) Class: \(NSStringFromClass(type(of: self)))") }
        group = vGroup
        uid.initView(vView: vView, vGroupTag: group)
        view = vView
        
        uid.addView(vSelf: lblTitle, vParent: nil)
        
        imageView         = uid.addImage(vMenuType: .imageBackground, vImageName: data.getMenuImageName(vMenuButtonType: .imageCA9Background), vhasFrame: false)
        
        pageCtrl = uid.addPageControl(vMenuType: .pageControl, vStartPage: 0, vMaxPages: mapData.count)
        
        updateDefaultColors()
    }
    //********************************************************************
    func updateDefaultColors()
    {
        lblTitle.updateDefaultColors()
    }
    //********************************************************************
    func resize()
    {
        uid.align(vView: pageCtrl,  horz: .center,  vert: .bottom,  widthPct: 0,    heightPct: 0,    subX: nil,  subY: nil)
        uid.align(vView: imageView, horz: .center,  vert: .top,     widthPct: 1.0,  heightPct: 0.80, subX: nil,  subY: nil)
        uid.align(vView: lblTitle, horz: .center,   vert: .topMargin,     widthPct: 1.0, heightPct: 0.08, subX: nil, subY: nil)
    }
    //**************************************************************************
    func hide()
    {
        uid.hide(vGroup: group)
    }
    //**************************************************************************
    func show()
    {
        uid.show(vGroup: group)
        updateButtons()
        pageCtrl.currentPage = data.mapSelected
    }
    //**************************************************************************
    func updateButtons()
    {
        var image = UIImage()
        data.mapSelected = pageCtrl.currentPage
        image = UIImage(named: data.getMapImageName())!
        imageView.image = image
        lblTitle.text = "\(data.getMapName())"
    }
    //**************************************************************************
    @objc func handleBackButton(button: UIBarButtonItem) {
        hide()
    }
    //**************************************************************************
    func swipeLeft()
    {
        pageCtrl.currentPage -= 1
        updateButtons()
    }
    //**************************************************************************
    func swipeRight()
    {
        pageCtrl.currentPage += 1
        updateButtons()
    }
    //**************************************************************************
}

