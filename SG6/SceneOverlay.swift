
import Foundation
import SpriteKit
import SceneKit
import Foundation
import AVFoundation
import CoreGraphics

//********************************************************************
// Scene overlay for Spritkit sounds
//********************************************************************

class SceneOverlay: SKScene
{
    static let sharedInstance = SceneOverlay.init(size: CGSize(width:640, height:480))
    var data = Data.sharedInstance
    
    //********************************************************************
    override init(size: CGSize)
    {
        super.init(size: size)
        self.isUserInteractionEnabled = false
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.scaleMode = .resizeFill
        
        addNodes()
//        for sNode in data.spriteNodes
//        {
//            addChild(sNode)
//        }
        
    }
    func removeNodes()
    {
        for sNode in data.spriteNodes
        {
            sNode.removeFromParent()
        }
        data.spriteNodes.removeAll()
    }
    func addNodes()
    {
        for sNode in data.spriteNodes
        {
            addChild(sNode)
        }
        print("Total: \(data.spriteNodes.count)")
    }
    //********************************************************************
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    //********************************************************************
}

