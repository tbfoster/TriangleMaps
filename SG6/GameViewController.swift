
import SceneKit
import UIKit
//**************************************************************************
class GameViewController: UIViewController, mainMenuDelegate, selectMapDelegate, gameControlDelegate, gameMenuDelegate
{
    func mainMenuSolveMap()
    {
        //**************************************************************************
        if(data.isSolveOn == true)
        {
            let _ = grid.reloadGKGraph()
            
            grid.showPathNodes()
        }
        else
        {
            grid.clearPathNodes()
        }
    }
    //**************************************************************************
    func gameMenuPhoto()
    {
        //sceneOverlay.removeNodes()
        self.navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        
        sceneOverlay.addNodes()
        gNodes.gameNodes.isHidden = true
    }
    //**************************************************************************
    func backToMenu()
    {
        navigationController?.navigationBar.isHidden = false
        sceneOverlay.removeNodes()
        gNodes.gameNodes.isHidden = false
    }
    //**************************************************************************
    // Select Menus
    //**************************************************************************
    func mainMenuGenerateMap()
    {
        data.mapSelected = 100
        gameStateManager.staging()
    }
    //**************************************************************************
    func selectMap()
    {
        gameStateManager.staging()
    }
    //**************************************************************************
    func mainMenuSelectMap() {
        showMenu(vMenu: .menuSelectMap)
        gameStateManager.selectSubMenu()
    }
    //**************************************************************************
    // Close Menus
    //**************************************************************************
    func selectMapCloses() {
        showMenu(vMenu: .menuMain)
        gameStateManager.selectMainMenu()
    }
    //**************************************************************************
    func gameMenuQuitsGame()
    {
        showMenu(vMenu: .menuMain)
    }
    //**************************************************************************
    func gameControlGameState(state: gameState) {
        switch(state)
        {
        case .run:
            gameStateManager.run()
            break
        default:
            break
        }
    }
    //**************************************************************************
    func setMainMenu(vMenu: selectMenuTypes)
    {
        switch vMenu {
        case .menuMain:
            navigationItem.leftBarButtonItems = [menuMain.btnNew, menuMain.btnLoad, menuMain.btnSolve]
            break
        case .menuSelectMap:
            navigationItem.leftBarButtonItems = [menuSelectMap.btnBack, menuSelectMap.btnEasy]
            break
        case .menuGame:
            navigationItem.leftBarButtonItems = [menuGame.btnBack, menuGame.btnDump, menuGame.btnPhoto, menuMain.btnSolve]
            break
        }
    }
    //**************************************************************************
    var gameControl = GameControl.sharedInstance
    var sceneOverlay = SceneOverlay.sharedInstance
    var util = Util.sharedInstance
    var grid = Grid.sharedInstance
    var data = Data.sharedInstance
    var gNodes = GameNodes.sharedInstance
    var gameStats = GameStats.sharedInstance
    
    var gameStateManager = GameStateManager()
    
    var dragMode: dragModes = .none
    var currentLocation = CGPoint.zero
    var beginLocation = CGPoint.zero
    
    var hitTestOptions = [SCNHitTestOption: Any]()
    
    var gameScene = SCNView()
    var gameDefaults = Defaults()
    
    var menuMain = MenuMain()
    var menuGame = MenuMainGame()
    var menuSelectMap = MenuSelectMap()
    
    var currentMenu: selectMenuTypes = .menuMain
    
    var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
    var swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(gesture:)))
    var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(gesture:)))
    var pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gesture:)))
    var lastDistance: CGFloat = 0
    
    var toolBar = UIToolbar(frame: .zero)
    //**************************************************************************
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    //**************************************************************************
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gameControl.gameStateDelegate = self
        menuMain.gameStateDelegate = self
        menuGame.gameStateDelegate = self
        menuSelectMap.gameStateDelegate = self
        
        view.addSubview(gameScene)
        
        hitTestOptions[SCNHitTestOption.backFaceCulling] = false
        hitTestOptions[SCNHitTestOption.searchMode] = SCNHitTestSearchMode.all.rawValue
        
        gameScene.isHidden = true
        gameScene.frame = view.bounds
        data.frameSize = view.bounds
        gameScene.scene = gNodes.scene
        gameScene.isPlaying = true
        gameScene.delegate = self
        gameScene.allowsCameraControl = false
        gameScene.overlaySKScene = sceneOverlay
        gameScene.showsStatistics = false // TODO Take this off
        gameScene.backgroundColor = UIColor.black
        gameScene.isUserInteractionEnabled = true
        gameScene.isMultipleTouchEnabled = true
        gameScene.frame = view.bounds
        
        // setup navigation controller
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = UIColor.white

        // Set current orientation before loading menu defaults
        checkOrientation(vWidth: view.bounds.width, vHeight: view.bounds.height)
        // Add gesture recognizers
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        
        swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.left
        
        swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.right
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        gameScene.addGestureRecognizer(tapGesture)
        gameScene.addGestureRecognizer(panGesture)
        gameScene.addGestureRecognizer(pinchGesture)
        gameScene.addGestureRecognizer(swipeLeftGesture)
        gameScene.addGestureRecognizer(swipeRightGesture)
        
        // Load Menus, provide a unique group for each to hide/show()
        menuGame.load(vGroup: 4000, vView: view)
        menuMain.load(vGroup: 5000, vView: view)
        menuSelectMap.load(vGroup: 6000, vView: view)
        
        resize()
        gameControl.initGameControl()
    }
    //**************************************************************************
    func updateOverlay()
    {
        sceneOverlay.addNodes()
    }
    //**************************************************************************
    override var prefersStatusBarHidden: Bool { get { return true } }
    //**************************************************************************
    // Have to switch height and width due to percentage calculations on subviews
    func checkOrientation(vWidth: CGFloat, vHeight: CGFloat)
    {
        //print("Width: \(vWidth) Height: \(vHeight)")
        data.screenWidth = vWidth
        data.screenHeight = vHeight
        if(vWidth < vHeight)
        {
            //print("Portrait")
            data.isLandscape = false
            data.landscapeScreenWidth = vHeight
            data.landscapeScreenHeight = vWidth
            
            data.portraitScreenWidth = vWidth
            data.portraitScreenHeight = vHeight
        }
        else
        {
            
            data.isLandscape = true
            data.landscapeScreenWidth = vWidth
            data.landscapeScreenHeight = vHeight
            
            data.portraitScreenWidth = vHeight
            data.portraitScreenHeight = vWidth
        }
    }
    //**************************************************************************
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        gameScene.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        checkOrientation(vWidth: size.width, vHeight: size.height)
        resize()
    }
    //**************************************************************************
    func resize()
    {
        if(data.isLandscape == true)
        {
            //print("Activate Landscape")
            NSLayoutConstraint.deactivate(data.portraitConstraints)
            NSLayoutConstraint.activate(data.landscapeConstraints)
        }
        else
        {
            //print("Activate Portrait")
            NSLayoutConstraint.deactivate(data.landscapeConstraints)
            NSLayoutConstraint.activate(data.portraitConstraints)
        }
    }
    //**************************************************************************
    func showMenu(vMenu: selectMenuTypes)
    {
        currentMenu = vMenu
        //print("Current Menu: \(currentMenu)")
        DispatchQueue.main.async
            {
                self.toolBar.isHidden = true
                self.setMainMenu(vMenu: vMenu)
                switch(vMenu)
                {
                case .menuMain:
                    self.swipeGestureOn()
                    self.gNodes.gameNodes.isHidden = true
                    self.menuMain.show()
                    self.gameScene.isHidden = false
                    break
                case .menuSelectMap:
                    self.setMainMenu(vMenu: .menuSelectMap)
                    self.swipeGestureOn()
                    self.gNodes.gameNodes.isHidden = true
                    self.menuSelectMap.show()
                    break
                case .menuGame:
                    self.panGestureOn()
                    self.menuGame.show()
                    break
                }
        }
    }
    //**************************************************************************
    func panGestureOn()
    {
        panGesture.isEnabled = true
        pinchGesture.isEnabled = true
        swipeLeftGesture.isEnabled = false
        swipeRightGesture.isEnabled = false
    }
    //**************************************************************************
    func swipeGestureOn()
    {
        panGesture.isEnabled = false
        pinchGesture.isEnabled = false
        swipeLeftGesture.isEnabled = true
        swipeRightGesture.isEnabled = true
    }
    //**************************************************************************
    func update(vTime: TimeInterval)
    {
        switch data.gameState
        {
        
        case .staging:
            if(gameStateManager.isStagingActive == false)
            {
                gameControl.startNewGame(vLoadSavedGame: data.isLoadingSavedGame)
                showMenu(vMenu: .menuGame)
                
                gameStateManager.run()
                gameStateManager.isStagingActive = true
            }
            break
        
        case .mainMenu:
            if(gameStateManager.isMainMenuActive == false)
            {
                showMenu(vMenu: .menuMain)
                gameStateManager.isMainMenuActive = true
            }
            break
        case .run:
            gameControl.updateTime(vTime: vTime)
            break
       
        default:
            break
        }
    }
    //**************************************************************************
    @objc func handleTap(recognizer: UITapGestureRecognizer)
    {
        //print("Game State on tap: \(data.gameState)")
        
        let location: CGPoint = recognizer.location(in: gameScene)
        
        let hitResults: [SCNHitTestResult] = gameScene.hitTest(location, options: hitTestOptions)
        for vHit in hitResults
        {
            if(vHit.node.name?.prefix(5) == "Panel")
            {
                gameControl.selectPanel(vPanel: vHit.node.name!)
                return
            }
        }
    }
    //**************************************************************************
    @objc func handlePan(recognizer: UIPanGestureRecognizer)
    {
        currentLocation = recognizer.location(in: gameScene)
        
        switch recognizer.state
        {
        case UIGestureRecognizer.State.began:
            dragMode = .drag
            beginLocation = recognizer.location(in: gameScene)
            data.lastMouseX = Float(beginLocation.x)
            data.lastMouseY = Float(beginLocation.y)
            dragMode = .strafe
            break
        case UIGestureRecognizer.State.changed:
            if(dragMode == .strafe)
            {
                gNodes.camera.strafe(vX: Float(currentLocation.x), vY: Float(currentLocation.y))
            }
            break
        case UIGestureRecognizer.State.ended:
            dragMode = .none
        default:
            break
        }
    }
    //**************************************************************************
    @objc func handleSwipeRight(gesture: UIGestureRecognizer)
    {
        switch currentMenu {
        case .menuSelectMap: menuSelectMap.swipeLeft(); break
        default:
            break
        }
    }
    //**************************************************************************
    @objc func handleSwipeLeft(gesture: UIGestureRecognizer)
    {
        switch currentMenu {
        case .menuSelectMap: menuSelectMap.swipeRight(); break
        default:
            break
        }
    }
    //**************************************************************************
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    //**************************************************************************
    @objc func handlePinch(gesture: UIGestureRecognizer)
    {
        if(gesture.numberOfTouches != 2) { return }
        
        switch gesture.state {
        case .began:
            lastDistance = distance(gesture.location(ofTouch: 0, in: gameScene), gesture.location(ofTouch: 1, in: gameScene))
            break
        case .changed:
            let currentDistance = distance(gesture.location(ofTouch: 0, in: gameScene), gesture.location(ofTouch: 1, in: gameScene))
            if(currentDistance < lastDistance *  0.9) { gNodes.camera.zoomIn();  lastDistance = currentDistance; return }
            if(currentDistance > lastDistance *  1.1) { gNodes.camera.zoomOut(); lastDistance = currentDistance; return }
            return
        case .cancelled, .ended:
            break
        default:
            break
        }
    }
    //**************************************************************************
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //********************************************************************
}
//********************************************************************
extension GameViewController: SCNSceneRendererDelegate
{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        update(vTime: time)
    }
}
//********************************************************************


