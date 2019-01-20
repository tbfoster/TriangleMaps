import Foundation
import SpriteKit
import SceneKit

//********************************************************************
// GameNodes - all game nodes and enumerations
// Menus also use gameTypes
//********************************************************************
class GameNodes
{
    static let sharedInstance = GameNodes()
    var data = Data.sharedInstance
    
    var scene = SCNScene()
    var camera = Camera()
    var gameNodes = SCNNode()
    
    var selectorNode = SCNNode(geometry: SCNCylinder(radius: 1.3, height: 0.001))
    
    var lightNode = SCNNode()
    var ambientLightNode = SCNNode()
    
    var emitterSpawn            = SCNParticleSystem(named: "art.scnassets/Particles/Spawn.scnp", inDirectory: nil)
    var emitterSpawnExit        = SCNParticleSystem(named: "art.scnassets/Particles/SpawnExit.scnp", inDirectory: nil)
    var emitterSmoke1           = SCNParticleSystem(named: "art.scnassets/Particles/Smoke1.scnp", inDirectory: nil)
    var emitterSmoke2           = SCNParticleSystem(named: "art.scnassets/Particles/Smoke2.scnp", inDirectory: nil)
    var emitterHitFromDefense   = SCNParticleSystem(named: "art.scnassets/Particles/hitFromMissile.scnp", inDirectory: nil)
    
    var emitterExplosionG1 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    var emitterExplosionG2 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    var emitterExplosionG3 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    var emitterExplosionG4 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    var emitterExplosionG5 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    var emitterExplosionG6 = SCNParticleSystem(named: "art.scnassets/Particles/ExplodeG1.scnp", inDirectory: nil)
    
    //********************************************************************
    init()
    {
        setParticleColorDefaults(vTheme: 0)
        
        emitterExplosionG1!.birthLocation = .surface
        emitterExplosionG2!.birthLocation = .surface
        emitterExplosionG3!.birthLocation = .surface
        emitterExplosionG4!.birthLocation = .surface
        emitterExplosionG5!.birthLocation = .surface
        emitterExplosionG6!.birthLocation = .surface
        
        let geometry = SCNSphere(radius: 0.4)
        emitterSpawn!.emitterShape = geometry
        emitterSpawnExit!.emitterShape = geometry
        emitterSmoke1!.emitterShape = geometry
        emitterSmoke2!.emitterShape = geometry
        emitterHitFromDefense!.emitterShape = geometry
        
        emitterExplosionG1!.emitterShape = geometry
        emitterExplosionG2!.emitterShape = geometry
        emitterExplosionG3!.emitterShape = geometry
        emitterExplosionG4!.emitterShape = geometry
        emitterExplosionG5!.emitterShape = geometry
        emitterExplosionG6!.emitterShape = geometry
        
        scene = SCNScene()
        
        gameNodes = SCNNode()
        gameNodes.name = "gameNodes"
        scene.rootNode.addChildNode(gameNodes)
        
        initLights()
        gameNodes.addChildNode(camera.cameraEye)
        gameNodes.addChildNode(camera.cameraFocus)
        
        setSelectorNode()
    }
    //********************************************************************
    func setParticleColorDefaults(vTheme: Int)
    {
        emitterExplosionG1!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g1ExplosionColor)
        emitterExplosionG2!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g2ExplosionColor)
        emitterExplosionG3!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g3ExplosionColor)
        emitterExplosionG4!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g4ExplosionColor)
        emitterExplosionG5!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g5ExplosionColor)
        emitterExplosionG6!.particleColor = data.getTextureColor(vTheme: vTheme, vTextureType: .g6ExplosionColor)
    }
    //********************************************************************
    func initLights()
    {
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.name = "Lighting"
        lightNode.position = SCNVector3(x: 0, y: 12, z: 0)
        gameNodes.addChildNode(lightNode)
        
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        ambientLightNode.name = "LightingAmbient"
        gameNodes.addChildNode(ambientLightNode)
    }
    //********************************************************************
    func setSelectorNode()
    {
        selectorNode.name = "Selector"
        let mat = SCNMaterial()
        mat.diffuse.contents  = UIColor.red
        selectorNode.geometry?.materials = [mat]
        selectorNode.position.x = -250  // just put it out of view until selected
        let moveUp = SCNAction.rotateBy(x: 0, y: CGFloat(Float(GLKMathDegreesToRadians(-90))), z: 0, duration: 0)
        selectorNode.runAction(moveUp)
        gameNodes.addChildNode(selectorNode)
    }
    //********************************************************************
    func getPanelNode(vPanelType: panelTypes, vUp: Bool) -> SCNNode
    {
        let bezierPath = UIBezierPath()
        bezierPath.move(to:    CGPoint(x: -2.0, y: -1.5))
        bezierPath.addLine(to: CGPoint(x:  2.0, y: -1.5))
        bezierPath.addLine(to: CGPoint(x:  0.0, y:  1.5))
        bezierPath.addLine(to: CGPoint(x: -2.0, y: -1.5))
        bezierPath.close()

        let plane = SCNShape(path: bezierPath, extrusionDepth: 0.1)
        
        //let plane = SCNCylinder(radius: 1.0, height: 0.5)
        
        plane.materials = []
        plane.materials = setTriPanelTextures(vPanelType: vPanelType)
        plane.firstMaterial?.isDoubleSided = false
        
        let vNode = SCNNode(geometry: plane)
        let moveUp = SCNAction.rotateBy(x: CGFloat(Float(GLKMathDegreesToRadians(-90))), y: 0, z: 0, duration: 0)
        vNode.runAction(moveUp)
        if(vUp == true)
        {
            let moveUp1 = SCNAction.rotateBy(x: 0, y: CGFloat(Float(GLKMathDegreesToRadians(180))), z: 0, duration: 0)
            vNode.runAction(moveUp1)
        }
        vNode.scale = SCNVector3(0.7, 0.7, 0.7)
        return vNode
    }
    //********************************************************************
    func setTriPanelTextures(vPanelType: panelTypes) -> [SCNMaterial]
    {
        let topMaterial = SCNMaterial()
        switch vPanelType
        {
        case .normal:   topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNormal.png"; break
        case .entry:    topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileEntryQuad.png"; break
        case .exit:     topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileExit.png"; break
        default: break
        }
        topMaterial.locksAmbientWithDiffuse = true
        
        return [topMaterial]
    }
    //********************************************************************
    func setPanelTextures(vPanelType: panelTypes) -> [SCNMaterial]
    {
        let sideMaterial = SCNMaterial()
        sideMaterial.diffuse.contents = UIColor.red
        sideMaterial.locksAmbientWithDiffuse = true
        
        let topMaterial = SCNMaterial()
        switch vPanelType
        {
        case .normal:   topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNormal.png"; break
        case .entry:    topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileEntry.png"; break
        case .exit:     topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileExit.png"; break
        case .path:     topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TilePath.png"; break
        case .none:     topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNone.png"; break
        }
        topMaterial.locksAmbientWithDiffuse = true
        
        let baseMaterial  = SCNMaterial()
        switch vPanelType
        {
        case .normal:   baseMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNormal.png"; break
        case .entry:    baseMaterial.diffuse.contents = UIColor(red: 240/255, green: 165/255, blue: 9/255, alpha: 1); break
        case .exit:     baseMaterial.diffuse.contents = UIColor(red: 238/255, green: 43/255, blue: 42/255, alpha: 1); break
        case .path:     baseMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNormal.png"; break
        case .none:     topMaterial.diffuse.contents = "art.scnassets/Images/Panels/TileNone.png"; break
        }
        baseMaterial.locksAmbientWithDiffuse = true
        
        let b1 = SCNMaterial()
        b1.diffuse.contents = UIColor.clear
        b1.locksAmbientWithDiffuse = true
        
        let b2 = SCNMaterial()
        b2.diffuse.contents = UIColor.clear
        b2.locksAmbientWithDiffuse = true
        
        let b3 = SCNMaterial()
        b3.diffuse.contents = UIColor.clear
        b3.locksAmbientWithDiffuse = true
        
        return [baseMaterial, topMaterial, sideMaterial, b1, b2, b3]
    }
    //********************************************************************
    func loadProjectileNodes(vGameType: gameTypes) -> SCNNode
    {
        let geometry = SCNSphere(radius: 0.05)
        geometry.segmentCount = 8
        let vNode = SCNNode(geometry: geometry)
        return vNode
    }
    //********************************************************************
    func loadDefenseNode(vTheme: Int, vGameType: gameTypes) -> SCNNode
    {
        switch vGameType {
        case .d0:
            let BoxGeometry = SCNCylinder(radius: 0.7, height: 0.7)
            BoxGeometry.radialSegmentCount = 6
            let vNode = SCNNode(geometry: BoxGeometry)
            BoxGeometry.materials = setRiserTextures(vTheme: vTheme, vGameType: vGameType)
            let vRotateAlways = SCNAction.rotateBy(x: 0, y: CGFloat(Float(GLKMathDegreesToRadians(2))), z: 0, duration: 0.15)
            let seq = SCNAction.repeatForever(vRotateAlways)
            vNode.runAction(seq)
            return vNode
        case .d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8, .d9, .d10:
            let BoxGeometry = SCNBox(width: 0.8, height: 0.8, length: 0.8, chamferRadius: 0.0)
            let vNode = SCNNode(geometry: BoxGeometry)
            BoxGeometry.materials = setDefenseTextures(vTheme: vTheme, vGameType: vGameType)
            
            let tubeGeometry = SCNTube(innerRadius: 0.03, outerRadius: 0.05, height: 0.9)
            let fireTube = SCNNode(geometry: tubeGeometry)
            tubeGeometry.firstMaterial?.diffuse.contents  = data.getTextureColor(vTheme: data.defenseTheme, vTextureType: .barrelColor)
            
            fireTube.position = SCNVector3(0, 0.2, -0.3)
            let vRotateX = SCNAction.rotateBy(x: CGFloat(Float(GLKMathDegreesToRadians(-90))), y: 0, z: 0, duration: 0)
            fireTube.runAction(vRotateX)
            vNode.addChildNode(fireTube)
            return vNode
        default:
            break
        }
        return SCNNode()
    }
    //********************************************************************
    func loadEnemyNode(vTheme: Int, vGameType: gameTypes) -> SCNNode
    {
        let geometry = SCNSphere(radius: 0.4)
        let vNodeGeometry = SCNNode(geometry: geometry)
        geometry.materials = setEnemyTextures(vTheme: vTheme, vGameType: vGameType)
        let vRotateX = SCNAction.rotateBy(x: CGFloat(Float(GLKMathDegreesToRadians(-50))), y: 0, z: 0, duration: 0)
        vNodeGeometry.runAction(vRotateX)
        
        let vRotateAlways = SCNAction.rotateBy(x: 0, y: CGFloat(Float(GLKMathDegreesToRadians(5))), z: 0, duration: 0.02)
        let seq = SCNAction.repeatForever(vRotateAlways)
        vNodeGeometry.runAction(seq)
        return vNodeGeometry
    }
    //********************************************************************
    func setRiserTextures(vTheme: Int, vGameType: gameTypes) -> [SCNMaterial]
    {
        let sidesMaterial = SCNMaterial()  // Sides
        sidesMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.defenseBase)
        sidesMaterial.locksAmbientWithDiffuse = true
        
        let topMaterial = SCNMaterial() // Top
        topMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.d0)
        topMaterial.locksAmbientWithDiffuse = true
        
        let bottomMaterial = SCNMaterial()  // Bottom
        bottomMaterial.diffuse.contents = UIColor.black // Doesn't display
        bottomMaterial.locksAmbientWithDiffuse = true
        return [sidesMaterial, topMaterial, bottomMaterial]
    }
    //********************************************************************
    func setDefenseTextures(vTheme: Int, vGameType: gameTypes) -> [SCNMaterial]
    {
        let backMaterial = SCNMaterial()  // Back
        backMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.defenseBase)
        backMaterial.locksAmbientWithDiffuse = true
        
        let rightMaterial = SCNMaterial() // Right
        rightMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.defenseBase)
        rightMaterial.locksAmbientWithDiffuse = true
        
        let frontMaterial  = SCNMaterial()  // Front
        frontMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.defenseBase)
        frontMaterial.locksAmbientWithDiffuse = true
        
        let leftMaterial = SCNMaterial()  // Left
        leftMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: gameTextureTypes.defenseBase)
        leftMaterial.locksAmbientWithDiffuse = true
        
        let BottomMaterial = SCNMaterial() // Bottom
        BottomMaterial.diffuse.contents = UIColor.black
        BottomMaterial.locksAmbientWithDiffuse = true
        
        let topMaterial = SCNMaterial()  // Top
        // Convert from game types to texture types
        let vTextureType = data.getTextureType(vGameType: vGameType)
        topMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: vTextureType)
        topMaterial.locksAmbientWithDiffuse = true
        return [backMaterial, rightMaterial, frontMaterial, leftMaterial, topMaterial, BottomMaterial]
    }
    //********************************************************************
    func setEnemyTextures(vTheme: Int, vGameType: gameTypes) -> [SCNMaterial]
    {
        let frontMaterial = SCNMaterial()  // Back
        // Convert from game types to texture types
        let vTextureType = data.getTextureType(vGameType: vGameType)
        frontMaterial.diffuse.contents = data.getTextureName(vTheme: vTheme, vTextureType: vTextureType)
        return [frontMaterial]
    }
    //********************************************************************
    // TODO
    func TEMPdumpChildrenCount(node : SCNNode) -> Int
    {
        var count = 0
        for child in node.childNodes
        {
            //print("Node Name: \(child.name)")
            count += TEMPdumpChildrenCount(node: child)
        }
        count += node.childNodes.count
        return count
    }
    //********************************************************************
}
