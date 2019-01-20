import UIKit

//**************************************************************************
class MenuBaseClass
{
    var data = Data.sharedInstance
    var group: Int = 0
    var uid = UIDesigner()
    var view = UIView()
    
    var lblTitle = ThemeLbl(vMenuType: .lblTitle)
    var toolBar = GameToolBar(frame: .zero)
    
    //**************************************************************************
    func load(vGroup: Int, vView: UIView)
    {
        if(uid.DEBUG) { print("Group: \(vGroup) Class: \(NSStringFromClass(type(of: self)))") }
        
        group = vGroup
        uid.initView(vView: vView, vGroupTag: group)
        view = vView
        
        uid.addView(vSelf: lblTitle, vParent: nil)
        uid.addView(vSelf: toolBar, vParent: nil)
        
        updateDefaultColors()
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
    }
    //********************************************************************
    func updateButtons() {  }
    //********************************************************************
    func updateDefaultColors()
    {
        lblTitle.updateDefaultColors()
    }
    //**************************************************************************
    func resize()
    {
        uid.align(vView: toolBar,  horz: .center, vert: .bottom, widthPct: 1.0, heightPct: 0.08, subX: nil, subY: nil)
        uid.align(vView: lblTitle, horz: .center, vert: .top,    widthPct: 1.0, heightPct: 0.08, subX: nil, subY: nil)
    }
    //**************************************************************************
    func swipeLeft()
    {
        print("MenuBaseClass Swipe Left from Class: \(NSStringFromClass(type(of: self)))")
    }
    //**************************************************************************
    func swipeRight()
    {
        print("MenuBaseClass Swipe Right from Class: \(NSStringFromClass(type(of: self)))")
    }
    //**************************************************************************
}
