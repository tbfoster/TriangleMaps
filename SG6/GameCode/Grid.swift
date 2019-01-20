import SceneKit
import Foundation
import GameplayKit

//********************************************************************
class GKPanelNode: GKGraphNode
{
    var name: String
    
    //********************************************************************
    init(vName: String)
    {
        name = vName
        
        super.init()
    }
    //********************************************************************
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //********************************************************************
}
//********************************************************************
struct SHIFT_DATA
{
    var desc: String
    var oddRow: Int
    var oddCol: Int
    var evenRow: Int
    var evenCol: Int
}
//********************************************************************
var shift: [[SHIFT_DATA]] =
    [
        [SHIFT_DATA(desc: "Down", oddRow:   1, oddCol:  0, evenRow:  1, evenCol:  0), // Right
            SHIFT_DATA(desc: "Down", oddRow:  -1, oddCol:  0, evenRow: -1, evenCol:  0), // Left
            SHIFT_DATA(desc: "Down", oddRow:   0, oddCol:  1, evenRow:  0, evenCol: -1),
            SHIFT_DATA(desc: "Down", oddRow:   0, oddCol: -1, evenRow:  0, evenCol:  1),
            SHIFT_DATA(desc: "Down", oddRow:  -1, oddCol: -1, evenRow:  1, evenCol: -1),
            SHIFT_DATA(desc: "Down", oddRow:  -1, oddCol:  1, evenRow:  1, evenCol:  1)],
        
        [SHIFT_DATA(desc: "Left", oddRow:   1, oddCol:  0, evenRow:  1, evenCol:  0),
         SHIFT_DATA(desc: "Left", oddRow:  -1, oddCol:  0, evenRow: -1, evenCol:  0),
         SHIFT_DATA(desc: "Left", oddRow:   0, oddCol: -1, evenRow:  0, evenCol: -1),
         SHIFT_DATA(desc: "Left", oddRow:   0, oddCol:  1, evenRow:  0, evenCol:  1),
         SHIFT_DATA(desc: "Left", oddRow:  -1, oddCol: -1, evenRow:  1, evenCol: -1),
         SHIFT_DATA(desc: "Left", oddRow:  -1, oddCol:  1, evenRow:  1, evenCol:  1)]
]

//********************************************************************
// Grid - Main grid layout, set up Dykstra, load components and grid UIcolors
//********************************************************************
public class Grid
{
    static let sharedInstance = Grid()
    
    var gNodes = GameNodes.sharedInstance
    var data = Data.sharedInstance
    var util = Util.sharedInstance
    
    var map = Maps()                                    // Maps class, load different maps
    var gridPanels:         [String:Panel] = [:]        // Main grid panel array, keyed by "Panel121"
    var gridPanelsRowCol:   [String:String] = [:]       // Convenience - lookup grid panel, matching gridPanels index for fast searching
    
    var startPanelX: Float = -11                        // Starting point for maps, so we center the grid.  X+ is right, X- is left of view
    var startPanelY: Float = 0                          // Panels are on Y = 0 plane
    var startPanelZ: Float = -18                        // Starting point for maps, so we center the grid.  Z- is away, Z+ is close to view
    
    var panelSelected: String = ""                      // Panel that was selected by user, used everywhere
    
    var globalPath: [String] = []
    var graphNodes: [GKPanelNode] = []                  // All active graph nodes with connections
    var myGraph = GKGraph()                             // declaring the Graph
    var entryPanelName: String = ""                     // Create maps names the entry panel
    var exitPanelName: String = ""                      // Create maps names the exit panel
    var shiftIndex: Int = 0                             // Try to shift path towards exit, doesn't really work all that great
    
    var borderNodes: [SCNNode?] = []                    // Border outline nodes...
    
    var TEMPAllConnectionsCount: Int = 0
    var TEMPPanelCount: Int = 0
    
    //********************************************************************************
    func initGrid()
    {
        map.load(vMap: data.mapSelected)
        setCameraOrientation()
        
        startPanelX = Float(0 - ((map.cols * 2) / 2))           // X spacing 2.0
        startPanelZ = Float(0 - ((Float(map.rows) * 2.2) / 2)) // Z spacing 2.2
        createPanels()
        
        loadAdjacentPanels()
        //let _ = reloadGKGraph()
        
        showPathNodes()
        
    }
    //********************************************************************************
    func setCameraOrientation()
    {
        gNodes.camera.left = map.left
        gNodes.camera.top = map.top
        gNodes.camera.right = map.right
        gNodes.camera.bottom = map.bottom
    }
    //********************************************************************************
    func clearGrid()
    {
        removePanelNodes()
    }
    //********************************************************************************
    func clearPathNodes()
    {
        for (_, vPanels) in gridPanels
        {
            if(vPanels.isPathNode == true)
            {
                vPanels.removePathNode()
            }
        }
    }
    //********************************************************************************
    func showPathNodes()
    {
        clearPathNodes()
        for vMove in globalPath
        {
            gridPanels[vMove]!.setPathNode()
        }
    }
    //********************************************************************************
    //let vRowColString = String(p1.col) + ":" + String(p1.row)
    func createPanels()
    {
        var ups: [Bool] = [true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false]
        var vUp: Bool = true
        var posX = startPanelX
        let posY = startPanelY
        var posZ = startPanelZ
        var offsetZ: Float = 0
        var oddRow: Bool = true
        var panelCount: Int = 0
        var vStartUp: Bool = true
        removePanelNodes()
        gNodes.selectorNode.position.x = -250  // just put it out of view until selected
        
        for rows in 0...map.rows
        {
            vStartUp = ups[rows]
            vUp = vStartUp
            oddRow = true
            posX = startPanelX
            for cols in 0...map.cols
            {
                offsetZ = 0.0
                if(vUp == false) { offsetZ = 0.2 }
                let vPanel = Panel.init(vIndex: panelCount, typeIndex: map.gamePattern[rows][cols], vRow: rows, vCol: cols, vUp: vUp,
                                        vPosition: SCNVector3Make(posX, posY, posZ + offsetZ))
                gridPanels[vPanel.panelName] = vPanel
                if(vPanel.type == .entry) { entryPanelName = vPanel.panelName }
                if(vPanel.type == .exit)  { exitPanelName  = vPanel.panelName }
                
                gridPanelsRowCol[String(vPanel.col) + ":" + String(vPanel.row)] = vPanel.panelName // Populate cross reference for row:col to panelName
                posX += 1.8
                oddRow = !oddRow
                panelCount += 1
                vUp = !vUp
            }
            posX = startPanelX
            posZ += 2.6
        }
    }
    //********************************************************************************
    func countAllConnections()
    {
        var vConnectionsCount: Int = 0
        for vConnections in graphNodes
        {
            let vConns = vConnections.connectedNodes
            vConnectionsCount += vConns.count
        }
        print("Active \(TEMPPanelCount) Adjacent: \(TEMPAllConnectionsCount) graphNodes: \(graphNodes.count) graphNodeConnections: \(vConnectionsCount)")
    }
    //********************************************************************************
    func loadAdjacentPanels()
    {
        TEMPAllConnectionsCount = 0
        TEMPPanelCount = 0
        
        myGraph.remove(graphNodes)
        graphNodes.removeAll()
        for (_, vPanel) in gridPanels
        {
            vPanel.adjacentPanels.removeAll()
            if(vPanel.type == .normal || vPanel.type == .entry || vPanel.type == .exit)
            {
                graphNodes.append(GKPanelNode(vName: vPanel.panelName))
                TEMPPanelCount += 1
                loadAdjacentPanel(rootPanel: vPanel, vRow: vPanel.row, vCol: vPanel.col + 1)
                loadAdjacentPanel(rootPanel: vPanel, vRow: vPanel.row, vCol: vPanel.col - 1)
                if(vPanel.up == true)
                {
                    loadAdjacentPanel(rootPanel: vPanel, vRow: vPanel.row - 1, vCol: vPanel.col)
                }
                else
                {
                    loadAdjacentPanel(rootPanel: vPanel, vRow: vPanel.row + 1, vCol: vPanel.col)
                }
            }
        }
        
        loadGraphConnections()
    }
    //********************************************************************************
    func loadAdjacentPanel(rootPanel: Panel, vRow: Int, vCol: Int)
    {
        let vAdjacentPanel = getPanelAt(vRow: vRow, vCol: vCol)
        
        if(vAdjacentPanel.type == .normal || vAdjacentPanel.type == .entry || vAdjacentPanel.type == .exit)
        {
            rootPanel.adjacentPanels.append(vAdjacentPanel.panelName)
            TEMPAllConnectionsCount += 1
        }
    }
    //********************************************************************************
    func getGraphNodeIndex(vName: String) -> Int
    {
        var vIndex = 0
        for vNode in graphNodes
        {
            if(vNode.name == vName) { return vIndex }
            vIndex += 1
        }
        print("ERROR - \(vName) NOT FOUND")
        return -1
    }
    //********************************************************************************
    func getGraphNodeByName(vName: String) -> GKPanelNode
    {
        for vNode in graphNodes
        {
            if(vNode.name == vName) { return vNode }
        }
        print("NOOOOOOOoOOOO")
        return GKPanelNode(vName: "DONT USE")
    }
    //********************************************************************************
    func solveGKGraph(vStart: String, vStop: String) -> [String]
    {
        let vStartIndex = getGraphNodeIndex(vName: vStart)
        let vExitIndex = getGraphNodeIndex(vName: vStop)
        
        var returnString: [String] = []
        let path: [GKPanelNode] = myGraph.findPath(from: graphNodes[vStartIndex], to: graphNodes[vExitIndex]) as! [GKPanelNode]
        for vPath in path
        {
            returnString.append(vPath.name)
        }
        return returnString
    }
    //********************************************************************************
    func loadGraphConnections()
    {
        for vGraphNode in graphNodes
        {
            let vPanel = getPanel(vPanelName: vGraphNode.name)
            for vAdjacent in vPanel.adjacentPanels
            {
                let vIndex = getGraphNodeIndex(vName: vAdjacent)
                vGraphNode.addConnections(to: [graphNodes[vIndex]], bidirectional: false)
            }
        }
        //print("Should be zero \(myGraph.nodes!.count)")
        myGraph.add(graphNodes)
    }
    //********************************************************************************
    func showAdjacentPanels()
    {
        var connectionPanels: [String] = []
        let vPanel = getPanel(vPanelName: panelSelected)
        for vAdjacent in vPanel.adjacentPanels
        {
            connectionPanels.append(vAdjacent)
        }
        //print("Adjacent: \(vPanel.panelName) Connections: \(connectionPanels)")
        //listConnections(vName: vPanel.panelName)
    }
    //********************************************************************************
//    func listConnections(vName: String)
//    {
//        var connectionPanels: [String] = []
//        let vNode = getGraphNodeByName(vName: vName)
//        let vPanel = getPanel(vPanelName: vName)
//        for vConns in vNode.connectedNodes
//        {
//            let vPrintNode = vConns as! GKPanelNode
//            connectionPanels.append(vPrintNode.name)
//        }
//
//        //print("OddRow: \(vPanel.oddRow) GKNode:   \(vName) Connections: \(connectionPanels)")
//    }
    //********************************************************************************
    func removePanelNodes()
    {
        for (_, vPanel) in gridPanels
        {
            vPanel.removeNode()
        }
        gridPanels.removeAll()
        gridPanelsRowCol.removeAll()
    }
    //********************************************************************************
    func reloadGKGraph() -> Bool
    {
        loadAdjacentPanels()
        globalPath.removeAll()
        globalPath = solveGKGraph(vStart: entryPanelName, vStop: exitPanelName)
        if(globalPath == [])
        {
            return false
        }
        else
        {
            return true
        }
    }
    //********************************************************************************
    func getPanelAt(vRow: Int, vCol: Int) -> Panel
    {
        // Lookup the rowCol wring in the cached values, use it for direct access to gridPanels - very fast
        let vColRowString = String(vCol) + ":" + String(vRow)
        
        if let vPanelString = gridPanelsRowCol[vColRowString]
        {
            return gridPanels[vPanelString]!
        }
        else
        {
            return Panel.init(vIndex: 0)
        }
    }
    //********************************************************************************
    func getPanel(vPanelName: String) -> Panel { return gridPanels[vPanelName]! }
    //********************************************************************************
    func getPanelType(vPanelName: String) -> panelTypes { return (gridPanels[vPanelName]?.type)! }
    //********************************************************************************
    func setPanelNormal(vPanelName: String) { gridPanels[vPanelName]!.setPanelNormal() }
    //********************************************************************
    func cancelCursor()
    {
        gNodes.selectorNode.isHidden = true
    }
    //********************************************************************
    func selectCursor() -> Bool
    {
        gNodes.selectorNode.isHidden = true
        // Return true if not a boundary panel
        if(gridPanels[panelSelected]!.isSelectable())
        {
            return true
        }
        return false
    }
    //********************************************************************
    func selectPanel() -> Bool
    {
        print("Selecting Panel: \(gridPanels[panelSelected]!.panelName)")
        gNodes.selectorNode.isHidden = false
        gNodes.selectorNode.position = gridPanels[panelSelected]!.getCursorPosition()
        gNodes.selectorNode.position.y -= 0.2
        return true
    }
    //********************************************************************************
    //    func removeAllConnections()
    //    {
    //        var vConnectionsCount: Int = 0
    //
    //        vConnectionsCount = 0
    //        for vConnections in myGraph.nodes!
    //        {
    //            let vConns = vConnections.connectedNodes
    //            vConnectionsCount += vConns.count
    //            vConnections.removeConnections(to: vConns, bidirectional: true)
    //        }
    //        print("Remove Connections: Node Count: \(myGraph.nodes!.count) Connections Count: \(vConnectionsCount)")
    //    }
    //********************************************************************************
    func showPhoto()
    {
        var offsetZ: Float = 0
        var vHeight: CGFloat = 30
        var vWidth: CGFloat = 30
        var startX: CGFloat = 35
        var startY: CGFloat = 100
        var posX: CGFloat = 35
        var posZ: CGFloat = 75
        var oddRow: Bool = true
        var panelCount: Int = 0
        
        if(data.isLandscape == true)
        {
            vWidth = 45
            vHeight = 40
            startX = 90
            startY = 12
            posX = startX
            posZ = startY
        }
        else
        {
            startX = 80
            startY = 280
            posX = startX
            posZ = startY
        }
        
        data.spriteNodes.removeAll()
        for rows in (0...map.rows).reversed()
        {
            oddRow = true
            posX = startX
            for cols in 0...map.cols
            {
                offsetZ = 0.0
                let vPanel = getPanelAt(vRow: rows, vCol: cols)
                if(vPanel.up == false) { offsetZ = -3 }
                let bezierPath = UIBezierPath()
                bezierPath.move(to:    CGPoint(x: -20.0, y: -15))
                bezierPath.addLine(to: CGPoint(x:  20.0, y: -15))
                bezierPath.addLine(to: CGPoint(x:   0.0, y:  15))
                bezierPath.addLine(to: CGPoint(x: -20.0, y: -15))
                bezierPath.close()
                
                let sNode = SKShapeNode(path: bezierPath.cgPath)
                //sNode.name = vPanel.panelName
                //sNode.size = CGSize(width: vWidth, height: vHeight)
                sNode.position.x = posX
                sNode.position.y = posZ + CGFloat(offsetZ)
                
                if(vPanel.up == true)
                {
                    let vRotate = SKAction.rotate(toAngle: CGFloat(GLKMathDegreesToRadians(180)), duration: 0)
                    sNode.run(vRotate)
                }
                //print("X: \(posX) Y: \(pZ)")
                if(map.gamePattern[rows][cols] == 0 || map.gamePattern[rows][cols] == 2 || map.gamePattern[rows][cols] == 3)
                {
                    data.spriteNodes.append(sNode)
                }
                //sNode.color = UIColor.lightGray
//                switch(map.gamePattern[rows][cols])
//                {
//                case 0: sNode.texture = SKTexture(imageNamed: "art.scnassets/Images/Panels/TileNormalDisplay.png"); break
//                case 2: sNode.texture = SKTexture(imageNamed: "art.scnassets/Images/Panels/TileEntryDisplay.png"); break
//                case 3: sNode.texture = SKTexture(imageNamed: "art.scnassets/Images/Panels/TileExitDisplay.png"); break
//                default: sNode.color = UIColor.clear; break
//                }
                
                posX += vWidth + 2
                oddRow = !oddRow
                panelCount += 1
            }
            posX = startX
            posZ += 40
        }
    }
    //********************************************************************************
    func DEBUGdumpMap()
    {
        var vString: String = ""
        print("[")
        for (_, vPanels) in gridPanels
        {
            if(vPanels.type == .entry || vPanels.type == .exit || vPanels.type == .normal)
            {
                let vX = util.fmt(vF: vPanels.position.x)
                let vY = util.fmt(vF: vPanels.position.y)
                let vZ = util.fmt(vF: vPanels.position.z)
                
                vString = "MAP_DETAIL(name: \"\(vPanels.panelName)\", up: \(vPanels.up), type: .\(vPanels.type), pos: SCNVector3(\(vX), \(vY), \(vZ)), conn: ["
                
                for vAdjacent in vPanels.adjacentPanels
                {
                    vString = vString + "\"\(vAdjacent)\", "
                }
                
                vString = vString + "]),"
                print(vString)
            }
        }
        
        
        print("],")
        
//        var mapDetails: [MAP_DETAIL] = [
//            MAP_DETAIL(panelName: "Panel11", panelType: .normal, position: SCNVector3(12, 12, 12),  connections: ["Panel:113",  "Panel:112"]),
//
//            ]
    }
    //********************************************************************************
    func DEBUGdumpArray()
    {
        //[9,9,9,9,9,9,9,9,9,9,9,9,9,9,9],
        print("From Grid DumpMap()************************************")
        var vLineString: String = "["
        
        for rows in 0...map.rows
        {
            for cols in 0...map.cols
            {
                let vPanel = getPanelAt(vRow: rows, vCol: cols)
                switch(vPanel.type)
                {
                case .entry:
                    vLineString = vLineString + "2"
                    break
                case .exit:
                    vLineString = vLineString + "3"
                    break
                case .normal:
                    vLineString = vLineString + "0"
                    break
                case .none:
                    vLineString = vLineString + "8"
                    break
                default:
                    break
                }
                if(cols < map.cols)
                {
                    vLineString = vLineString + ", "
                }
            }
            vLineString = vLineString + "], "
            print("\(vLineString)")
            vLineString = "["
        }
    }
    //********************************************************************************
}

