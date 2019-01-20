//
//  SubClasses.swift
//  Alienable Rights HC1
//
//  Created by terrybfoster on 12/18/18.
//  Copyright © 2018 terrybfoster. All rights reserved.
//
import UIKit
import Foundation

//**************************************************************************
// GameBtn
//**************************************************************************
class GameToolBar: UIToolbar
{
    var data = Data.sharedInstance
    var uid = UIDesigner()
    
    //**************************************************************************
    override init(frame: CGRect)
    {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.white
        //self.barTintColor = UIColor.red
        //self.tintColor = UIColor.blue
        self.delegate = self as? UIToolbarDelegate
        self.isHidden = true
        self.sizeToFit()
        self.isTranslucent = false
    }
    //**************************************************************************
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //**************************************************************************
}
//**************************************************************************
// GameBtn
//**************************************************************************
class GameBtn: UIButton
{
    var data = Data.sharedInstance
    
    //**************************************************************************
    init(vMenuType: menuButtonTypes) {  // Can't add the view on init anyways
        super.init(frame: .zero)
        
        setTitleColor(UIColor.red, for: .disabled)
        self.setImage(data.getMenuImage(vMenuButtonType: vMenuType), for: .normal)
    }
    //**************************************************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //**************************************************************************
    func show() { self.isHidden = false }
    //**************************************************************************
    func hide() { self.isHidden = true }
    //**************************************************************************
    func enable()
    {
        self.isEnabled = true
    }
    //**************************************************************************
    func disable()
    {
        self.isEnabled = false
    }
    //**************************************************************************
    func setTexture(vMenuType: menuButtonTypes)
    {
        self.setImage(data.getMenuImage(vMenuButtonType: vMenuType), for: .normal)
    }
    //**************************************************************************
}
//**************************************************************************
// ThemeBtn
//**************************************************************************
class ThemeBtn: UIButton
{
    var data = Data.sharedInstance
    var textureType: gameTextureTypes = .themeRiserBtn
    
    //**************************************************************************
    init(vMenuType: menuButtonTypes, vTextureType: gameTextureTypes) {
        super.init(frame: .zero)
        
        textureType = vTextureType
        self.setTitleColor(UIColor.red, for: .disabled)
        
        self.updateDefaultColors(vTheme: 0)
    }
    //**************************************************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //**************************************************************************
    func show() { isHidden = false }
    //**************************************************************************
    func hide() { isHidden = true }
    //**************************************************************************
    func enable()
    {
        self.isEnabled = true
    }
    //**************************************************************************
    func disable()
    {
        self.isEnabled = false
    }
    //**************************************************************************
    func updateDefaultColors(vTheme: Int)
    {
        self.setImage(data.getTextureImage(vTheme: vTheme, vTextureType: textureType), for: .normal)
    }
    //**************************************************************************
}
//**************************************************************************
// ThemeLbl
//**************************************************************************
class ThemeLbl: UILabel
{
    var data = Data.sharedInstance
    var textureType: gameTextureTypes = .themeRiserBtn
    
    //**************************************************************************
    init(vMenuType: menuButtonTypes) {
        super.init(frame: .zero)
        
        self.textAlignment = .center
        self.font = data.font
        self.adjustsFontSizeToFitWidth = true
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.updateDefaultColors()
    }
    //**************************************************************************
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //**************************************************************************
    func show() { self.isHidden = false }
    //**************************************************************************
    func hide() { self.isHidden = true }
    //**************************************************************************
    func updateDefaultColors()
    {
        self.font = data.font
    }
    //**************************************************************************
}
