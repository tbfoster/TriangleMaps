import SceneKit
import Foundation

//**********************************************************
// Helper class, DirVir used throughout code for ueler angles,
// set targets vectors, and all vector math routines
//**********************************************************
class DirectionVector
{
    var nPosition:          SCNVector3 = SCNVector3Make(0, 0, 0)
    var nRight:             SCNVector3 = SCNVector3Make(0, 0, 0)
    var nUp:                SCNVector3 = SCNVector3Make(0, 0, 0)
    var nScale:             SCNVector3 = SCNVector3Make(1, 1, 1)
    var nTarget:            SCNVector3 = SCNVector3Make(0, 0, 0)
    var plotPosition:       SCNVector3 = SCNVector3Make(0, 0, 0)
    var speed:              Float = 0.1
    var PI: Float =         Float.pi
    var SCROLL_BOUNDARY_X:  Float = 8
    var SCROLL_BOUNDARY_Y:  Float = 8

    var nPositionSave:      SCNVector3 = SCNVector3Make(0, 0, 0)
    var nRightSave:         SCNVector3 = SCNVector3Make(0, 0, 0)
    var nUpSave:            SCNVector3 = SCNVector3Make(0, 0, 0)
    var nScaleSave:         SCNVector3 = SCNVector3Make(1, 1, 1)
    var nTargetSave:        SCNVector3 = SCNVector3Make(0, 0, 0)
    var plotPositionSave:   SCNVector3 = SCNVector3Make(0, 0, 0)

    //**************************************************************************
    func savePosition()
    {
        nPositionSave = nPosition
        nRightSave = nRight
        nUpSave = nUp
        nScaleSave = nScale
        nTargetSave = nTarget
        plotPositionSave = plotPosition
    }
    //**************************************************************************
    func restorePosition(vNode: SCNNode)
    {
        nPosition = nPositionSave
        nRight = nRightSave
        nUp = nUpSave
        nScale = nScaleSave
        nTarget = nTargetSave
        plotPosition = plotPositionSave

        vNode.transform.m11 = nRight.x
        vNode.transform.m12 = nRight.y
        vNode.transform.m13 = nRight.z
        vNode.transform.m21 = nUp.x
        vNode.transform.m22 = nUp.y
        vNode.transform.m23 = nUp.z
        vNode.transform.m31 = nTarget.x
        vNode.transform.m32 = nTarget.y
        vNode.transform.m33 = nTarget.z
        vNode.scale = nScale
    }
    //**************************************************************************
    func setPosition(vPosition: SCNVector3)
    {
        nPosition.x = vPosition.x
        nPosition.y = vPosition.y
        nPosition.z = vPosition.z
        resetNormals()
    }
    //**************************************************************************
    func setPosition(vX: Float, vY: Float, vZ: Float)
    {
        nPosition.x = vX
        nPosition.y = vY
        nPosition.z = vZ
        resetNormals()
    }
    //**************************************************************************
    func setScale(vX: Float, vY: Float, vZ: Float)
    {
        nScale.x = vX
        nScale.y = vY
        nScale.z = vZ
    }
    //**************************************************************************
    func resetNormals()
    {
        nRight.x = 1
        nRight.y = 0
        nRight.z = 0

        nUp.x = 0
        nUp.y = 1
        nUp.z = 0

        nTarget.x = 0
        nTarget.y = 0
        nTarget.z = -1
    }
    //**************************************************************************
    // Set target and transform node variable
    func setTarget(node: SCNNode, vPlotPosition: SCNVector3)
    {
        var projectedTarget: SCNVector3
        var vTarget: SCNVector3

        plotPosition.x = vPlotPosition.x
        plotPosition.y = vPlotPosition.y
        plotPosition.z = vPlotPosition.z

        vTarget = cgVecSub(v1: plotPosition, v2: nPosition)
        projectedTarget = vTarget

        if ((abs(vTarget.x) < 0.00001) && (abs(vTarget.z) < 0.00001))
        {
            projectedTarget.x = 0
            projectedTarget = normalized(vVector: projectedTarget)

            nRight.x = 1.0
            nRight.y = 0
            nRight.z = 0
            nUp = cgCrossProduct(v1: projectedTarget, v2: nRight)
            nTarget = vTarget
            let x = cgCrossProduct(v1: nTarget, v2: nUp)
            nRight = cgVecScalarMult(v: x, s: -1)
        }
        else
        {
            projectedTarget.y = 0
            projectedTarget = normalized(vVector: projectedTarget)

            nUp.x = 0
            nUp.y = 1.0
            nUp.z = 0
            let temp = cgCrossProduct(v1: projectedTarget, v2: nUp)
            nRight = cgVecScalarMult(v: temp, s: -1)
            nTarget = vTarget
            nUp = cgCrossProduct(v1: nTarget, v2: nRight)
        }
        nTarget = normalized(vVector: nTarget)
        nRight = normalized(vVector: nRight)
        nUp = normalized(vVector: nUp)

        node.transform.m11 = nRight.x
        node.transform.m12 = nRight.y
        node.transform.m13 = nRight.z
        node.transform.m21 = nUp.x
        node.transform.m22 = nUp.y
        node.transform.m23 = nUp.z
        node.transform.m31 = nTarget.x
        node.transform.m32 = nTarget.y
        node.transform.m33 = nTarget.z
        node.scale = nScale
    }
    //**************************************************************************
    // Set target and transform node variable
    func setTargetNegativeZ(node: SCNNode, vPlotPosition: SCNVector3)
    {
        var projectedTarget: SCNVector3
        var vTarget: SCNVector3
        
        plotPosition.x = vPlotPosition.x
        plotPosition.y = vPlotPosition.y
        plotPosition.z = vPlotPosition.z
        
        vTarget = cgVecSub(v1: plotPosition, v2: nPosition)
        projectedTarget = vTarget
        
        if ((abs(vTarget.x) < 0.00001) && (abs(vTarget.z) < 0.00001))
        {
            projectedTarget.x = 0
            projectedTarget = normalized(vVector: projectedTarget)
            
            nRight.x = 1.0
            nRight.y = 0
            nRight.z = 0
            nUp = cgCrossProduct(v1: projectedTarget, v2: nRight)
            nTarget = vTarget
            let x = cgCrossProduct(v1: nTarget, v2: nUp)
            nRight = cgVecScalarMult(v: x, s: -1)
        }
        else
        {
            projectedTarget.y = 0
            projectedTarget = normalized(vVector: projectedTarget)
            
            nUp.x = 0
            nUp.y = 1.0
            nUp.z = 0
            let temp = cgCrossProduct(v1: projectedTarget, v2: nUp)
            nRight = cgVecScalarMult(v: temp, s: -1)
            nTarget = vTarget
            nUp = cgCrossProduct(v1: nTarget, v2: nRight)
        }
        nTarget = normalized(vVector: nTarget)
        nRight = normalized(vVector: nRight)
        nUp = normalized(vVector: nUp)
        
        node.transform.m11 = nRight.x
        node.transform.m12 = nRight.y
        node.transform.m13 = nRight.z
        node.transform.m21 = nUp.x
        node.transform.m22 = nUp.y
        node.transform.m23 = nUp.z
        node.transform.m31 = nTarget.x
        node.transform.m32 = nTarget.y
        node.transform.m33 = nTarget.z
        node.scale = nScale
    }
    //**************************************************************************
    // Set targeting facing an abstract point, do not transform node
    func setTargetFacing(vX: Float, vY: Float, vZ: Float)
    {
        var projectedTarget: SCNVector3
        var vTarget: SCNVector3

        plotPosition.x = vX
        plotPosition.y = vY
        plotPosition.z = vZ

        vTarget = cgVecSub(v1: plotPosition, v2: nPosition) 
        projectedTarget = vTarget 

        if ((abs(vTarget.x) < 0.00001) && (abs(vTarget.z) < 0.00001))
        {
            projectedTarget.x = 0 
            projectedTarget = normalized(vVector: projectedTarget)

            nRight.x = 1.0
            nRight.y = 0
            nRight.z = 0
            nUp = cgCrossProduct(v1: projectedTarget, v2: nRight) 
            nTarget = vTarget
            let x = cgCrossProduct(v1: nTarget, v2: nUp) 
            nRight = cgVecScalarMult(v: x, s: -1) 
        } else
        {
            projectedTarget.y = 0
            projectedTarget = normalized(vVector: projectedTarget)

            nUp.x = 0
            nUp.y = 1.0
            nUp.z = 0
            let temp = cgCrossProduct(v1: projectedTarget, v2: nUp)
            nRight = cgVecScalarMult(v: temp, s: -1)
            nTarget = vTarget
            nUp = cgCrossProduct(v1: nTarget, v2: nRight)
        }
        nTarget = normalized(vVector: nTarget)
        nRight = normalized(vVector: nRight)
        nUp = normalized(vVector: nUp)
    }
    //**************************************************************************
    func setTargetFacingAndOrient(node: SCNNode, vX: Float, vY: Float, vZ: Float)
    {
        var projectedTarget: SCNVector3
        var vTarget: SCNVector3

        plotPosition.x = vX
        plotPosition.y = vY
        plotPosition.z = vZ

        vTarget = cgVecSub(v1: plotPosition, v2: nPosition)
        projectedTarget = vTarget

        if ((abs(vTarget.x) < 0.00001) && (abs(vTarget.z) < 0.00001))
        {
            projectedTarget.x = 0
            projectedTarget = normalized(vVector: projectedTarget)

            nRight.x = 1.0
            nRight.y = 0
            nRight.z = 0
            nUp = cgCrossProduct(v1: projectedTarget, v2: nRight)
            nTarget = vTarget
            let x = cgCrossProduct(v1: nTarget, v2: nUp)
            nRight = cgVecScalarMult(v: x, s: -1)
        } else
        {
            projectedTarget.y = 0
            projectedTarget = normalized(vVector: projectedTarget)

            nUp.x = 0
            nUp.y = 1.0
            nUp.z = 0
            let temp = cgCrossProduct(v1: projectedTarget, v2: nUp)
            nRight = cgVecScalarMult(v: temp, s: -1)
            nTarget = vTarget
            nUp = cgCrossProduct(v1: nTarget, v2: nRight)
        }
        nTarget = normalized(vVector: nTarget)
        nRight = normalized(vVector: nRight)
        nUp = normalized(vVector: nUp)
        node.transform.m11 = nRight.x
        node.transform.m12 = nRight.y
        node.transform.m13 = nRight.z
        node.transform.m21 = nUp.x
        node.transform.m22 = nUp.y
        node.transform.m23 = nUp.z
        node.transform.m31 = nTarget.x
        node.transform.m32 = nTarget.y
        node.transform.m33 = nTarget.z
        node.scale = nScale
    }
    //**************************************************************************
    func setTransform(vMat4: SCNMatrix4)
    {
        nRight.x = vMat4.m11
        nRight.y = vMat4.m12
        nRight.z = vMat4.m13
        nUp.x = vMat4.m21
        nUp.y = vMat4.m22
        nUp.z = vMat4.m23
        nTarget.x = vMat4.m31
        nTarget.y = vMat4.m32
        nTarget.z = vMat4.m33
    }
    //**************************************************************************
    func transformNode(vNode: SCNNode)
    {
        vNode.transform.m11 = nRight.x
        vNode.transform.m12 = nRight.y
        vNode.transform.m13 = nRight.z
        vNode.transform.m21 = nUp.x
        vNode.transform.m22 = nUp.y
        vNode.transform.m23 = nUp.z
        vNode.transform.m31 = nTarget.x
        vNode.transform.m32 = nTarget.y
        vNode.transform.m33 = nTarget.z
        vNode.scale = nScale
    }
    //**************************************************************************
    func roll(vNode: SCNNode, vAngle: Float)
    {
        nRight = cgVecAdd(v1: cgCosineAngle(v1: nRight, a: (vAngle / 180 * PI)), v2: cgSineAngle(v1: nUp,  a: (vAngle / 180 * PI)))
        nUp = cgCrossProduct(v1: nRight, v2: nTarget)
        transformNode(vNode: vNode)
    }
    //**************************************************************************
    func pitch(vNode: SCNNode, vAngle: Float)
    {
        nTarget = cgVecAdd(v1: cgCosineAngle(v1: nTarget, a: (vAngle / 180 * PI)), v2: cgSineAngle(v1: nUp, a: Float (vAngle / 180 * PI)))
        nUp = cgCrossProduct(v1: nRight, v2: nTarget)
        transformNode(vNode: vNode)
    }
    //**************************************************************************
    func yaw(vNode: SCNNode, vAngle: Float)
    {
        nRight = cgVecAdd(v1: cgCosineAngle(v1: nRight, a: (vAngle / 180 * PI)), v2: cgSineAngle(v1: nTarget, a: (vAngle / 180 * PI)))
        nTarget = cgCrossProduct(v1: nUp, v2: nRight)
        transformNode(vNode: vNode)
    }
    //**************************************************************************
    func strafeX(vNode: SCNNode, vAmount: Float)
    {
        nPosition = cgVecAdd(v1: nPosition, v2: cgVecScalarMult(v: nRight, s: vAmount))
        vNode.position = nPosition
    }
    //**************************************************************************
    func strafeY(vNode: SCNNode, vAmount: Float)
    {
        nPosition = cgVecAdd(v1: nPosition, v2: cgVecScalarMult(v: nTarget, s: vAmount))
        vNode.position = nPosition
    }
    //**************************************************************************
    func cgCosineAngle(v1: SCNVector3, a: Float) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x * cos(a), v1.y * cos(a), v1.z * cos(a))
        return vVector
    }
    //**************************************************************************
    func cgSineAngle(v1: SCNVector3, a: Float) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x * sin(a), v1.y * sin(a), v1.z * sin(a))
        return vVector
    }
    //**************************************************************************
    func cgVecAdd(v1: SCNVector3, v2: SCNVector3) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
        return vVector
    }
    //**************************************************************************
    func cgVecSub(v1: SCNVector3, v2: SCNVector3) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
        return vVector
    }
    //**************************************************************************
    func cgCrossProduct(v1: SCNVector3, v2: SCNVector3) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.y * v2.z - v2.y * v1.z,
                                     v2.x * v1.z - v1.x * v2.z,
                                     v1.x * v2.y - v2.x * v1.y)
        return vVector
    }
    //**************************************************************************
    func cgVecScalarMult(v: SCNVector3, s: Float) -> SCNVector3
    {
        let vVector = SCNVector3Make(v.x * s, v.y * s, v.z * s)
        return vVector
    }
    //**************************************************************************
    func moveForward(vNode: SCNNode)
    {
        nPosition.x = nPosition.x + (nTarget.x * speed) 
        nPosition.y = nPosition.y + (nTarget.y * speed) 
        nPosition.z = nPosition.z + (nTarget.z * speed)
        vNode.position = nPosition
    }
    //**************************************************************************
    func moveBackward(vNode: SCNNode)
    {
        nPosition.x = nPosition.x - (nTarget.x * speed) 
        nPosition.y = nPosition.y - (nTarget.y * speed) 
        nPosition.z = nPosition.z - (nTarget.z * speed)
        vNode.position = nPosition
    }
    //**************************************************************************
    func length(vVector: SCNVector3) -> Float
    {
        return sqrt(vVector.x * vVector.x + vVector.y * vVector.y + vVector.z * vVector.z)
    }
    //**************************************************************************
    func normalized(vVector: SCNVector3) -> SCNVector3
    {
        let tLength = length(vVector: vVector)
        let tVector: SCNVector3 = SCNVector3Make(vVector.x / tLength,
                                                 vVector.y / tLength,
                                                 vVector.z / tLength)
        return tVector
    }
    //**************************************************************************
}
