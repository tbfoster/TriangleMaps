
import SceneKit
import Foundation
import MessageUI

//********************************************************************
// Utility class, various formats, rounding and helper functions
//********************************************************************
class Util
{
    static let sharedInstance = Util()
    //********************************************************************
    func distance2D(vector1: SCNVector3, vector2: SCNVector3) -> Float
    {
        let x: Float = (vector1.x - vector2.x) * (vector1.x - vector2.x)
        let z: Float = (vector1.z - vector2.z) * (vector1.z - vector2.z)

        let temp = x + z
        return Float(sqrtf(Float(temp)))
    }
    //********************************************************************
    func distance3D(vector1: SCNVector3, vector2: SCNVector3) -> Float
    {
        let x: Float = (vector1.x - vector2.x) * (vector1.x - vector2.x)
        let y: Float = (vector1.y - vector2.y) * (vector1.y - vector2.y)
        let z: Float = (vector1.z - vector2.z) * (vector1.z - vector2.z)
        
        let temp = x + y + z
        return Float(sqrtf(Float(temp)))
    }
    //********************************************************************
    func fmt2Decimals(vAmount: Int) -> String
    {
        return String(format: "%02d", vAmount)
    }
    //********************************************************************
    func fmt3Decimals(vAmount: Int) -> String
    {
        return String(format: "%03d", vAmount)
    }
    //********************************************************************
    func fmt5Decimals(vAmount: Int) -> String
    {
        return String(format: "%5d", vAmount)
    }
    //********************************************************************
    func fmt$(vF: Float) -> String
    {
        return String(format: " $%.02f", vF)
    }
    //********************************************************************
    func fmtPnct(vF: Float) -> String
    {
        return String(format: "%.0f", vF)
    }
    //********************************************************************
    func fmtPercent(vF: Float) -> String
    {
        return String(format: "%3.0f", vF * 100)
    }
    //********************************************************************
    func fmt(vF: Float) -> String
    {
        return String(format: "%.02f", vF)
    }
    //********************************************************************
    func fmt5(vF: Float) -> String
    {
        return String(format: "%5.0f", vF)
    }
    //********************************************************************
    func fmt0(vF: Float) -> String
    {
        return String(format: "%.0f", vF)
    }
    //********************************************************************
    func fmt3(vF: Float) -> String
    {
        return String(format: "%3.0f", vF)
    }
    //********************************************************************
    func randomHundreth() -> Double
    {
        let randomNum:UInt32 = arc4random_uniform(100)
        return Double(Double(randomNum) / Double(1000))
    }
    //********************************************************************
    func randomHundreth() -> Float
    {
        let randomNum:UInt32 = arc4random_uniform(100)
        return Float(Float(randomNum) / Float(1000))
    }
    //**************************************************************************
    func cgVecSub(v1: SCNVector3, v2: SCNVector3) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
        return vVector
    }
    //**************************************************************************
    func cgVecScalarMult(v: SCNVector3, s: Float) -> SCNVector3
    {
        let vVector = SCNVector3Make(v.x * s, v.y * s, v.z * s)
        return vVector
    }
    //**************************************************************************
    func cgVecAdd(v1: SCNVector3, v2: SCNVector3) -> SCNVector3
    {
        let vVector = SCNVector3Make(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
        return vVector
    }
    //********************************************************************
    func lerp(start: SCNVector3, end: SCNVector3, percent: Float) -> SCNVector3
    {
        let v3 = cgVecSub(v1: end, v2: start)
        let v4 = cgVecScalarMult(v: v3, s: percent)
        return cgVecAdd(v1: start, v2: v4)
    }
    
    //********************************************************************
}
//********************************************************************
extension SCNGeometry
{
    class func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry
    {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)

        return SCNGeometry(sources: [source], elements: [element])
    }
    //********************************************************************
}
