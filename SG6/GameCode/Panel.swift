import Foundation
import SceneKit
import GameplayKit

public class Panel
{
    var data = Data.sharedInstance
    var gNodes = GameNodes.sharedInstance
    
    //var textNode = SCNText()
    
    var node = SCNNode()                                // Panel node
    var laneNodes: [SCNNode] = []
    var panelName: String = ""                          // Name of gridPanel
    var index: Int = 0                                  // Panel Count "Panel:01" or "Panel:121"
    var position = SCNVector3Make(0, 0, 0)              // 3D position of panel
    var type: panelTypes = .none                        // Type of panel
    var up: Bool = true                             // OddRow, must have for positioning hexagonal tiles
    var row: Int = 99                                   // row
    var col: Int = 99                                   // col
    var panelCount: Int = 0                             // Panel Count "Panel:01" or "Panel:121"
    var selected: Bool = false                          // Selected is used for cursor operations
    var adjacentPanels: [String] = []                   // All panels that are adjacent to me
    var isPathNode: Bool = false
    
    var laneX: [Int:Float] = [0:-0.5, 1:0.5, 2:-0.3, 3:0.3,  4:-0.3, 5:0.3]
    var laneY: [Int:Float] = [0:1,    1:1,   2:1,    3:1,    4:1,    5:1]
    var laneZ: [Int:Float] = [0:0,    1:0,   2:-0.5, 3:-0.5, 4:0.5,  5:0.5]
    
    //**************************************************************************
    init(vIndex: Int)
    {
        index = vIndex
        panelName = "Panel:\(index)"
        node.name = panelName
    }
    //**************************************************************************
    init(vIndex: Int, typeIndex: Int, vRow: Int, vCol: Int, vUp: Bool, vPosition: SCNVector3)
    {
        index = vIndex
        panelName = "Panel:\(index)"
        
        up = vUp
        row = vRow
        col = vCol
        position = vPosition
        
        switch typeIndex
        {
        case 0:  setType(vPanelType: .normal); break
        case 2:  setType(vPanelType: .entry);  break
        case 3:  setType(vPanelType: .exit);   break
        default: setType(vPanelType: .none);   break
        }
    }
    //**************************************************************************
    func removePathNode()
    {
        if(type == .normal)
        {
            node.geometry?.materials = gNodes.setPanelTextures(vPanelType: .normal)
        }
        isPathNode = false
    }
    //**************************************************************************
    func setPathNode()
    {
        if(type == .entry || type == .exit || type == .none) { return }
        node.geometry?.materials = gNodes.setPanelTextures(vPanelType: .path)
        isPathNode = true
    }
    //**************************************************************************
    func setType(vPanelType: panelTypes)
    {
        for vLaneNode in laneNodes
        {
            vLaneNode.removeFromParentNode()
        }
        laneNodes.removeAll()
        type = vPanelType
        // We don't need a node or lanes if we aren't displaying them
        
        //TEMPshowText()
        node.removeFromParentNode()
        node = gNodes.getPanelNode(vPanelType: type, vUp: up)
        node.position = position
        node.name = panelName
        //let vRotate = SCNAction.rotateTo(x: 0, y: -1.57, z: 0, duration: 0)
        //node.runAction(vRotate)
        for vLoop in 0...5
        {
            let geometry = SCNSphere(radius: 0.2)
            let vNode = SCNNode(geometry: geometry)
            vNode.position.x = node.position.x + laneX[vLoop]!
            vNode.position.y = node.position.y + laneY[vLoop]!
            vNode.position.z = node.position.z + laneZ[vLoop]!
            vNode.isHidden = true
            laneNodes.append(vNode)
            gNodes.gameNodes.addChildNode(laneNodes[vLoop])
        }
        gNodes.gameNodes.addChildNode(node)
    }
    //********************************************************************************
    func isSelectable() -> Bool
    {
        return true
    }
    //********************************************************************************
    func isNormal() -> Bool
    {
        if(type == .normal) { return true }
        return false
    }
    //********************************************************************************
    func getType() -> panelTypes { return type }
    //********************************************************************************
    func getCursorPosition() -> SCNVector3 { return SCNVector3Make(position.x, position.y + 0.4, position.z) }
    //********************************************************************************
    // Test the panel for Dyktra (hidden), so no animation, of ok setPanelOccupied is called
    //********************************************************************************
    func setPanelNormal()
    {
        type = .normal
        node.geometry?.materials = gNodes.setPanelTextures(vPanelType: type)
    }
    //********************************************************************
    func removeNode()
    {
        for vLaneNode in laneNodes
        {
            vLaneNode.geometry = nil
            vLaneNode.removeFromParentNode()
        }
        
        node.geometry = nil
        node.removeFromParentNode()
    }
    //********************************************************************
    // Uncomment TextNode
    func TEMPshowText()
    {
        if(type == .normal || type == .entry || type == .exit)
        {
            let text = SCNText(string: panelName, extrusionDepth: 0.2)
            text.firstMaterial?.diffuse.contents = UIColor.white
            text.font = UIFont(name: "Arial", size: 12)
            let textNode = SCNNode(geometry: text)
            textNode.position = position
            textNode.position.x -= 0.7
            textNode.position.y = 1.0
            textNode.scale = SCNVector3(0.04, 0.04, 0.04)
            let vRotateX = SCNAction.rotateTo(x: -40, y: 0, z: 0, duration: 0)
            textNode.runAction(vRotateX)
            gNodes.gameNodes.addChildNode(textNode)
        }
    }
    //********************************************************************
}
