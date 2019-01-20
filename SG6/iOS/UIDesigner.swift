import UIKit

//**********************************************************
struct AppColor {
    static let lblHeight: CGFloat       = 0.08
    
    static let buttonHeight: CGFloat    = 0.12
    static let buttonWidth: CGFloat    = 0.18
    static let mapHeight: CGFloat       = 0.54
    
    static let backBtnWidth:  CGFloat   = 0.12
    static let backBtnHeight: CGFloat   = 0.21
    
//    static let backBtnWidth:  CGFloat   = 0.21
//    static let backBtnHeight: CGFloat   = 0.12
    
    static let displayBtnWidth:  CGFloat   = 0.09
    static let displayBtnHeight: CGFloat   = 0.135
    // Slider
    static let sliderTint              = UIColor.red
    // Sub Menu background for HUD, AddDefense, UpgradeDefense
    static let backDropWidth:CGFloat   = 1.0
    static let backDropHeight:CGFloat  = 0.20
    static let backDropText            = UIColor.black
    static let backDrop                = UIColor.cyan
    // Player level and defense level progress bar
    static let playerBG                  = UIColor.black
    static let playerBorder              = UIColor.lightGray
    static let playerNormal              = UIColor.white
    static let playerMasked              = UIColor.white
    static let playerShade               = UIColor.red
    // Labels
    static let hudText                  = UIColor.white
    static let hudBG                    = UIColor.clear
    static let defLblBG                 = UIColor.black
    static let defLblText               = AppColor.btnBG
    static let defLblBorder             = UIColor.lightGray
    // All Regular Buttons
    static let btnBG                    = UIColor.blue
    static let btnBGDisabled            = UIColor.lightGray
    static let btnText                  = UIColor.white
    static let btnTextDisabled          = UIColor.white
    static let btnBorder                = UIColor.lightGray
    // Buttons for display only
    static let displayBG                = UIColor.lightGray
    static let displayBGDisabled        = UIColor.blue
    static let displayText              = UIColor.white
    static let displayTextDisabled      = UIColor.white
    static let btnDisplayBorder         = UIColor.black
    // Main menu buttons
    static let btnMainBG             = UIColor.clear
    static let btnMainSelect         = UIColor.clear
    static let btnMainNormal         = UIColor.white
    static let btnMainDisabled       = UIColor.black
    static let btnMainBorder         = UIColor.black
}
//**********************************************************
class UIDesigner
{
    var data = Data.sharedInstance
    
    var view = UIView()
    var groupTag: Int = 10000
    var screenConstant: CGFloat = 1
    var DEBUG: Bool = false
    //**********************************************************
    func initView(vView: UIView, vGroupTag: Int)
    {
        view = vView
        switch UIDevice.current.userInterfaceIdiom
        {
        case .phone:
            data.font = UIFont.init(name: "GurmukhiMN", size: 26)!
            data.menuFont = UIFont.init(name: "GurmukhiMN", size: 32)!
            screenConstant = 5
            break
        case .pad:
            data.font = UIFont.init(name: "GurmukhiMN", size: 32)!
            data.menuFont = UIFont.init(name: "GurmukhiMN", size: 48)!
            screenConstant = 5
            break
        case .unspecified:
            screenConstant = 1
            data.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight.regular)
            break
        default:
            break
        }
        groupTag = vGroupTag
    }
    //**********************************************************
    func addView(vSelf: UIView, vParent: UIView?)
    {
        //print("Group: \(groupTag)")
        vSelf.tag = groupTag
        vSelf.translatesAutoresizingMaskIntoConstraints = false
        if(vParent == nil)
        {
            view.addSubview(vSelf)
        }
        else
        {
            vParent!.addSubview(vSelf)
        }
    }
    //**********************************************************
    func addLabel(vMenuType: menuButtonTypes, vView: UIView?, vAlignText: NSTextAlignment, vhasFrame: Bool) -> UILabel
    {
        let vLabel = UILabel()
        vLabel.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) vLabel -> \(vLabel.tag)") }
        vLabel.text = ""
        vLabel.textAlignment = vAlignText
        vLabel.textColor = UIColor.white
        vLabel.backgroundColor = UIColor.clear
        vLabel.font = data.font
        vLabel.adjustsFontSizeToFitWidth = true
        if(vhasFrame)
        {
            vLabel.layer.cornerRadius = 8
            vLabel.layer.borderWidth = 3
            vLabel.layer.borderColor = AppColor.defLblBorder.cgColor
        }
        vLabel.translatesAutoresizingMaskIntoConstraints = false
        if(vView == nil)
        {
            view.addSubview(vLabel)
        }
        else
        {
            vView!.addSubview(vLabel)
        }
        
        return vLabel
    }
    //**********************************************************
    func addSlider(vMenuType: menuButtonTypes, vView: UIView?, vhasFrame: Bool, vBackground: UIColor, vTint: UIColor, vThumb: UIColor) -> UISlider
    {
        let vSlider = UISlider()
        vSlider.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) UISlider -> \(vSlider.tag)") }
        vSlider.backgroundColor = UIColor.clear
        vSlider.minimumValue = 0
        vSlider.maximumValue = 1
        vSlider.isContinuous = true
        vSlider.value = 50
        vSlider.tintColor = vTint
        vSlider.thumbTintColor = vThumb
        
        if(vhasFrame)
        {
            vSlider.layer.cornerRadius = 5
            vSlider.layer.borderColor = UIColor.lightGray.cgColor
            vSlider.layer.borderWidth = 3
        }
        vSlider.translatesAutoresizingMaskIntoConstraints = false
        if(vView == nil)
        {
            view.addSubview(vSlider)
        }
        else
        {
            vView!.addSubview(vSlider)
        }
        return vSlider
    }
    //**********************************************************
    func addTextView(vMenuType: menuButtonTypes, vView: UIView?, vAlignText: NSTextAlignment, vhasFrame: Bool) -> UITextView
    {
        let vTextView = UITextView()
        
        vTextView.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) vTextView -> \(vTextView.tag)") }
        vTextView.textAlignment = vAlignText
        vTextView.textColor = UIColor.white
        vTextView.backgroundColor = UIColor.blue
        vTextView.font = data.font
        
        if(vhasFrame)
        {
            vTextView.layer.cornerRadius = 8
            vTextView.layer.borderWidth = 3
            vTextView.layer.borderColor = UIColor.lightGray.cgColor
        }
        vTextView.translatesAutoresizingMaskIntoConstraints = false
        if(vView == nil)
        {
            view.addSubview(vTextView)
        }
        else
        {
            vView!.addSubview(vTextView)
        }
        
        return vTextView
    }
    //**********************************************************
    func addImage(vMenuType: menuButtonTypes, vImageName: String, vhasFrame: Bool) -> UIImageView
    {
        let vImage = UIImage(named: vImageName)
        let vImageView = UIImageView(image: vImage)
        
        vImageView.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) vImageView -> \(vImageView.tag)") }
        if(vhasFrame)
        {
            vImageView.layer.cornerRadius = 8
            vImageView.layer.borderWidth = 3
            vImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        vImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vImageView)
        return vImageView
    }
    //**********************************************************
    func addButton(vMenuType: menuButtonTypes, vView: UIView?, vAlignText: alignText, vHasBoarder: Bool) -> UIButton
    {
        let vButton = UIButton()
        vButton.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) vButton -> \(vButton.tag)") }
        vButton.setTitle("Generic Title", for: .normal)
        vButton.titleLabel?.font = data.font
        vButton.setTitleColor(UIColor.white, for: .normal)
        vButton.setTitleColor(UIColor.red, for: .disabled)
        vButton.backgroundColor = UIColor.clear
        vButton.frame = CGRect(x: 50, y: 50, width: 70, height: 50)
        vButton.layer.cornerRadius = vButton.frame.width / 2
        vButton.clipsToBounds = true
        vButton.layer.borderColor = UIColor.lightGray.cgColor
        vButton.layer.borderWidth = 0
        vButton.showsTouchWhenHighlighted = true
        if(vHasBoarder == true) { vButton.layer.borderWidth = 3 }
        
        vButton.translatesAutoresizingMaskIntoConstraints = false
        if(vView == nil)
        {
            view.addSubview(vButton)
        }
        else
        {
            vView!.addSubview(vButton)
        }
        return vButton
    }
    //**********************************************************
    func addPageControl(vMenuType: menuButtonTypes, vStartPage: Int, vMaxPages: Int) -> UIPageControl
    {
        let vPageControl = UIPageControl()
        vPageControl.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) PageControl -> \(vPageControl.tag)") }
        vPageControl.currentPage = vStartPage
        vPageControl.numberOfPages = vMaxPages
        vPageControl.pageIndicatorTintColor = AppColor.btnBG
        vPageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vPageControl)
        return vPageControl
    }
    //**********************************************************
    func addPickerView(vMenuType: menuButtonTypes) -> UIPickerView
    {
        let vPickerView = UIPickerView()
        vPickerView.tag = groupTag
        if(DEBUG == true) { print("\(vMenuType) vPickerView -> \(vPickerView.tag)") }
        vPickerView.translatesAutoresizingMaskIntoConstraints = false
        vPickerView.backgroundColor = UIColor.black
        vPickerView.tintColor = UIColor.red
        vPickerView.layer.cornerRadius = 8
        vPickerView.layer.borderWidth = 3
        //vPickerView.layer.borderColor = AppColor.defaultGame.cgColor
        
        view.addSubview(vPickerView)
        return vPickerView
    }
    //**********************************************************
    func addScrollView(vMenuType: menuButtonTypes) -> UIScrollView
    {
        let vScrollView = UIScrollView()
        vScrollView.tag = groupTag 
        if(DEBUG == true) { print("\(vMenuType) vScrollView -> \(vScrollView.tag)") }
        
        vScrollView.contentSize = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height)
        vScrollView.showsVerticalScrollIndicator = true
        //vScrollView.flashScrollIndicators()
        vScrollView.isScrollEnabled = true
        
        //vScrollView.alwaysBounceHorizontal = false
        vScrollView.translatesAutoresizingMaskIntoConstraints = false
        //vScrollView.bounces = true
        vScrollView.layer.cornerRadius = 8
        vScrollView.layer.borderWidth = 3
        //vScrollView.layer.borderColor = AppColor.defaultGame.cgColor
        
        view.addSubview(vScrollView)
        return vScrollView
    }
    //**********************************************************
    func alignWithParent(vView: UIView, vParentView: UIView, horz: alignHorizontol, vert: alignVertical, widthPct: CGFloat, heightPct: CGFloat, subX: UIView?, subY: UIView?)
    {
        landscape(vView: vView, vParentView: vParentView, horz: horz, vert: vert, widthPct: widthPct, heightPct: heightPct, subX: subX, subY: subY)
        portrait(vView:  vView, vParentView: vParentView, horz: horz, vert: vert, widthPct: widthPct, heightPct: heightPct, subX: subX, subY: subY)
    }
    //**********************************************************
    func align(vView: UIView, horz: alignHorizontol, vert: alignVertical, widthPct: CGFloat, heightPct: CGFloat, subX: UIView?, subY: UIView?)
    {
        landscape(vView: vView, vParentView: view, horz: horz, vert: vert, widthPct: widthPct, heightPct: heightPct, subX: subX, subY: subY)
        portrait(vView:  vView, vParentView: view, horz: horz, vert: vert, widthPct: widthPct, heightPct: heightPct, subX: subX, subY: subY)
    }
    //**********************************************************
    func landscape(vView: UIView, vParentView: UIView, horz: alignHorizontol, vert: alignVertical, widthPct: CGFloat, heightPct: CGFloat, subX: UIView?, subY: UIView?)
    {
        var constraints: [NSLayoutConstraint] = []
        
        switch horz
        {
        case .left:         constraints.append(alignLeft(vView: vView, vParentView: vParentView)); break
        case .right:        constraints.append(alignRight(vView: vView)); break
        case .center:       constraints.append(alignCenterX(vView: vView)); break
        case .rightOf:      constraints.append(alignRightOf(vView: vView,     superView: subX!)); break
        case .rightInside:  constraints.append(alignRightInside(vView: vView, superView: subX!)); break
        case .leftOf:       constraints.append(alignLeftOf(vView: vView,      superView: subX!)); break
        case .leftInside:   constraints.append(alignLeftInside(vView: vView,  superView: subX!)); break
        case .leftEven:     constraints.append(alignLeftEven(vView: vView,    superView: subX!)); break
        }
        
        switch vert
        {
        case .top:          constraints.append(alignTop(vView: vView, vParentView: vParentView)); break
        case .topMargin:    constraints.append(alignTopMargin(vView: vView)); break
        case .bottom:       constraints.append(alignBottom(vView: vView)); break
        case .center:       constraints.append(alignCenterY(vView: vView)); break
        case .above:        constraints.append(alignAbove(vView: vView,       superView: subY!)); break
        case .aboveInside:  constraints.append(alignAboveInside(vView: vView, superView: subY!)); break
        case .belowInside:  constraints.append(alignBelowInside(vView: vView, superView: subY!)); break
        case .below:        constraints.append(alignBelow(vView: vView,       superView: subY!)); break
        }
        
        if(widthPct != 0)
        {
            constraints.append(alignSetWidth(vView: vView, vConstantWidth: widthPct * data.landscapeScreenWidth))
        }
        
        if(heightPct != 0)
        {
            constraints.append(alignSetHeight(vView: vView, vConstantHeight: heightPct * data.landscapeScreenHeight))
        }
        
        for vConstraint in constraints
        {
            data.landscapeConstraints.append(vConstraint)
        }
    }
    //**********************************************************
    func portrait(vView: UIView, vParentView: UIView, horz: alignHorizontol, vert: alignVertical, widthPct: CGFloat, heightPct: CGFloat, subX: UIView?, subY: UIView?)
    {
        var constraints: [NSLayoutConstraint] = []
        
        switch horz
        {
        case .left:         constraints.append(alignLeft(vView: vView, vParentView: vParentView)); break
        case .right:        constraints.append(alignRight(vView: vView)); break
        case .center:       constraints.append(alignCenterX(vView: vView)); break
        case .rightOf:      constraints.append(alignRightOf(vView: vView,     superView: subX!)); break
        case .rightInside:  constraints.append(alignRightInside(vView: vView, superView: subX!)); break
        case .leftOf:       constraints.append(alignLeftOf(vView: vView,      superView: subX!)); break
        case .leftInside:   constraints.append(alignLeftInside(vView: vView,  superView: subX!)); break
        case .leftEven:     constraints.append(alignLeftEven(vView: vView,    superView: subX!)); break
        }
        
        switch vert
        {
        case .top:          constraints.append(alignTop(vView: vView, vParentView: vParentView)); break
        case .topMargin:    constraints.append(alignTopMargin(vView: vView)); break
        case .bottom:       constraints.append(alignBottom(vView: vView)); break
        case .center:       constraints.append(alignCenterY(vView: vView)); break
        case .above:        constraints.append(alignAbove(vView: vView,       superView: subY!)); break
        case .aboveInside:  constraints.append(alignAboveInside(vView: vView, superView: subY!)); break
        case .belowInside:  constraints.append(alignBelowInside(vView: vView, superView: subY!)); break
        case .below:        constraints.append(alignBelow(vView: vView,       superView: subY!)); break
        }
        
        if(widthPct != 0)
        {
            constraints.append(alignSetWidth(vView: vView, vConstantWidth: widthPct * data.portraitScreenWidth))
        }
        
        if(heightPct != 0)
        {
            constraints.append(alignSetHeight(vView: vView, vConstantHeight: heightPct * data.portraitScreenHeight))
        }
        
        for vConstraint in constraints
        {
            data.portraitConstraints.append(vConstraint)
        }
    }
    //**********************************************************
    func alignSetWidth(vView: UIView, vConstantWidth: CGFloat)-> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: vConstantWidth)
    }
    //**********************************************************
    func alignSetHeight(vView: UIView, vConstantHeight: CGFloat)-> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: vConstantHeight)
    }
    //**********************************************************
    func alignCenterX(vView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignCenterY(vView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignRightOf(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignLeftOf(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: -screenConstant)
    }
    //**********************************************************
    func alignAbove(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: -screenConstant)
    }
    //**********************************************************
    func alignBelow(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignLeft(vView: UIView, vParentView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .leftMargin, relatedBy: .equal, toItem: vParentView, attribute: .leftMargin, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignRight(vView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .rightMargin, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignTop(vView: UIView, vParentView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .top, relatedBy: .equal, toItem: vParentView, attribute: .top, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignBottom(vView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    }
    //**********************************************************
    func alignTopMargin(vView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height * 0.08 )
    }
    //**********************************************************
    func alignAboveInside(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: screenConstant)
    }
    //**********************************************************
    func alignBelowInside(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: -screenConstant)
    }
    //**********************************************************
    func alignLeftInside(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: screenConstant * 2) //10)
    }
    //**********************************************************
    func alignLeftEven(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: 0)
    }
    //**********************************************************
    func alignRightInside(vView: UIView, superView: UIView) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1, constant: -(screenConstant * 2)) //10)10)
    }
    //**************************************************************************
    func alignFixedHeight(vView: UIView, vFixedHeight: CGFloat) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: vView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: vFixedHeight)
    }
    //**************************************************************************
    func enable(vView: UIButton, vBackGround: UIColor, vTextColor: UIColor)
    {
        vView.isEnabled = true
        vView.setTitleColor(vTextColor , for: .normal)
        vView.backgroundColor = vBackGround
        //vView.layer.borderColor = AppColor.defaultGame.cgColor
    }
    //**************************************************************************
    func disable(vView: UIButton, vBackGround: UIColor, vTextColor: UIColor)
    {
        vView.isEnabled = false
        vView.setTitleColor(vTextColor, for: .disabled)
        vView.backgroundColor = vBackGround
        //vView.layer.borderColor = AppColor.defaultDisabled.cgColor
    }
    //**************************************************************************
    func showAllActive()
    {
        for subview in view.subviews
        {
            if(subview.isHidden == false)
            {
                print("  -> \(subview.tag)")
            }
        }
    }
    //**************************************************************************
    func show(vGroup: Int)
    {
        for subview in view.subviews
        {
            if(subview.tag == vGroup)
            {
                subview.isHidden = false
            }
        }
    }
    //**************************************************************************
    func hide(vGroup: Int)
    {
        for subview in view.subviews
        {
            if(subview.tag == vGroup)
            {
                subview.isHidden = true
            }
        }
    }
    //**********************************************************
}


