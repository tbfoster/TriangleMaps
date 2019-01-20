import Foundation
import SceneKit

//********************************************************************
// Main camera class, nodes loaded from GameNodes
//********************************************************************
class Camera
{
    var data = Data.sharedInstance
    var util = Util.sharedInstance
    var gameDefaults = Defaults()
    
    var cameraEye = SCNNode()
    var cameraFocus = SCNNode()
    
    // Boundaries for user to scroll
    var left: Float = 0
    var top: Float = 0
    var right: Float = 0
    var bottom: Float = 0
    
    var zoomLevel: Int = 35
    var zoomLevelMax: Int = 35              // Max number of zoom levels
    
    //********************************************************************
    init()
    {
        cameraEye.name = "Camera Eye"
        cameraFocus.name = "Camera Focus"
        
        cameraEye.camera = SCNCamera()
        cameraFocus.isHidden = true
        cameraFocus.position  =  SCNVector3(x: 0, y: 0, z: 0)
        cameraEye.constraints = []
        cameraEye.position = SCNVector3(x: 0, y: 32, z: 0.1)
        cameraFocus.position = SCNVector3Make(0, 0, 0)
        
        let vConstraint = SCNLookAtConstraint(target: cameraFocus)
        vConstraint.isGimbalLockEnabled = true
        cameraEye.constraints = [vConstraint]
        setZoom()
    }
    //********************************************************************
    func cleanup()
    {
        cameraEye.removeFromParentNode()
        cameraFocus.removeFromParentNode()
    }
    //********************************************************************
    func setZoomLevel(vLevel: Int)
    {
        if(vLevel <= 1) { return }
        if(vLevel >= zoomLevelMax) { return }
        zoomLevel = vLevel
        setZoom()
    }
    //********************************************************************
    // For screen print
    func zoomMax()
    {
        zoomLevel = 1
        setZoom()
    }
    //********************************************************************
    func zoomIn()
    {
        zoomLevel -= 1
        if(zoomLevel < 10) { zoomLevel = 10}
        setZoom()
    }
    //********************************************************************
    func zoomOut()
    {
        zoomLevel += 1
        if(zoomLevel > zoomLevelMax) { zoomLevel = zoomLevelMax}
        setZoom()
    }
    //********************************************************************
    func setZoom()
    {
        cameraEye.constraints = []
        cameraEye.position.y = Float(zoomLevel)
        let vConstraint = SCNLookAtConstraint(target: cameraFocus)
        vConstraint.isGimbalLockEnabled = true
        cameraEye.constraints = [vConstraint]
    }
    //********************************************************************
    func strafeCamera(deltaX: Float, deltaZ: Float)
    {
        cameraEye.constraints = []
        
        if(deltaX < 0)
        {
            if((cameraEye.position.x - deltaX) < right)
            {
                cameraEye.position.x -= deltaX;
                cameraFocus.position.x -= deltaX
            }
        }
        if(deltaX > 0)
        {
            if((cameraEye.position.x + deltaX) > left)
            {
                cameraEye.position.x -= deltaX;
                cameraFocus.position.x -= deltaX
            }
        }
        if(deltaZ < 0)
        {
            if((cameraEye.position.z - deltaZ) < bottom)
            {
                cameraEye.position.z -= deltaZ
                cameraFocus.position.z -= deltaZ
            }
        }
        if(deltaZ > 0)
        {
            if((cameraEye.position.z + deltaZ) > top)
            {
                cameraEye.position.z -= deltaZ;
                cameraFocus.position.z -= deltaZ
            }
        }
        
        let vConstraint = SCNLookAtConstraint(target: cameraFocus)
        vConstraint.isGimbalLockEnabled = true
        cameraEye.constraints = [vConstraint]
    }
    //********************************************************************
    func strafe(vX: Float, vY: Float)
    {
        let deltaX: Float = Float((vX - data.lastMouseX) * 0.20)
        let deltaY: Float = Float((vY - data.lastMouseY) * 0.20)
        
        strafeCamera(deltaX: deltaX, deltaZ: deltaY)
        
        data.lastMouseX = vX
        data.lastMouseY = vY
    }
    //********************************************************************
}
