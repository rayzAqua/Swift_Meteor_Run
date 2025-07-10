import SpriteKit

public extension CGSize {
    static func withPercent(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(MyScreenSize.screenSize.width) / 100 * width, height: CGFloat(MyScreenSize.screenSize.height) / 100 * height)
    }
    static func withPercentScaledByWith(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(MyScreenSize.screenSize.width) / 100 * width, height: CGFloat(MyScreenSize.screenSize.width) / 100 * height)
    }
    static func withPercentScaledByHeight(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(MyScreenSize.screenSize.height) / 100 * width, height: CGFloat(MyScreenSize.screenSize.height) / 100 * height)
    }
    static func withPercentScaled(roundByWidth width: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(MyScreenSize.screenSize.width) / 100 * width, height: CGFloat(MyScreenSize.screenSize.width) / 100 * width)
    }
    static func withPercentScaled(roundByHeight height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(MyScreenSize.screenSize.height) / 100 * height, height: CGFloat(MyScreenSize.screenSize.height) / 100 * height)
    }
}

public extension CGPoint {
    static func withPercent(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(MyScreenSize.screenSize.width) / 100 * x, y: CGFloat(MyScreenSize.screenSize.height) / 100 * y)
    }
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    func normalized() -> CGPoint {
        return self / length()
    }
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    static func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    static func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    static func milde() -> CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    static func top() -> CGPoint {
        return CGPoint(x: 0.5, y: 1)
    }
    static func bottom() -> CGPoint {
        return CGPoint(x: 0.5, y: 0)
    }
    static func left() -> CGPoint {
        return CGPoint(x: 0, y: 0.5)
    }
    static func right() -> CGPoint {
        return CGPoint(x: 1, y: 0.5)
    }
    static func leftTop() -> CGPoint {
        return CGPoint(x: 0, y: 1)
    }
    static func rightTop() -> CGPoint {
        return CGPoint(x: 1, y: 1)
    }
    static func leftBottom() -> CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    static func rightBottom() -> CGPoint {
        return CGPoint(x: 1, y: 0)
    }
    func distanceTo(_ position: CGPoint) -> CGFloat {
        return sqrt(self.x + position.x * self.y + position.y)
    }
}

public extension Int {
    init(from: Int, to: Int) {
        self = from < to ?
            Int(arc4random_uniform(UInt32(to - from + 1))) + from :
            Int(arc4random_uniform(UInt32(from - to + 1))) + to
    }
    init(fromZeroTo value: Int) {
        self = Int(from: 0, to: value)
    }
}

public extension Double {
    init(from: Double, to: Double) {
        self = from < to ?
            (Double(arc4random()) / Double(UInt32.max)) * (to - from) + from :
            (Double(arc4random()) / Double(UInt32.max)) * (from - to) + to
    }
    init(fromZeroTo value: Double) {
        self = Double(from: 0, to: value)
    }
    init(degreeToRadian degree: Double) {
        self = degree * Double.pi / 180.0
    }
}

public extension Float {
    init(from: Float, to: Float) {
        self = from < to ?
            (Float(arc4random()) / Float(UInt32.max)) * (to - from) + from :
            (Float(arc4random()) / Float(UInt32.max)) * (from - to) + to
    }
    init(fromZeroTo value: Float) {
        self = Float(from: 0, to: value)
    }
    init(degreeToRadian degree: Float) {
        self = degree * Float.pi / 180.0
    }
}

public extension CGFloat {
    init(from: CGFloat, to: CGFloat) {
        self = from < to ?
            (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (to - from) + from :
            (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (from - to) + to
    }
    init(fromZeroTo value: CGFloat) {
        self = CGFloat(from: 0, to: value)
    }
    init(degreeToRadian degree: CGFloat) {
        self = degree * CGFloat.pi / 180.0
    }
}

public extension Bool {
    static func random() -> Bool {
        return Int(from: 1, to: 2) == 1 ? true : false
    }
}

extension Array where Element: Equatable {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    @discardableResult
    public mutating func remove(_ item: Element) -> Array {
        if let index = firstIndex(where: { item == $0 }) {
            remove(at: index)
        }
        return self
    }
    @discardableResult
    public mutating func removeAll(_ item: Element) -> Array {
        removeAll(where: { item == $0 })
        return self
    }
}

public extension CGVector {
    init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
    init(angle: CGFloat) {
        self.init(dx: cos(angle), dy: sin(angle))
    }
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGVector {
        self.dx += dx
        self.dy += dy
        return self
    }
    func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    func lengthSquared() -> CGFloat {
        return dx*dx + dy*dy
    }
    func normalized() -> CGVector {
        let len = length()
        return len>0 ? self / len : CGVector.zero
    }
    mutating func normalize() -> CGVector {
        self = normalized()
        return self
    }
    func distanceTo(_ vector: CGVector) -> CGFloat {
        return (self - vector).length()
    }
    var angle: CGFloat {
        return atan2(dy, dx)
    }
}

public func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}
public func += (left: inout CGVector, right: CGVector) {
    left = left + right
}
public func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}
public func -= (left: inout CGVector, right: CGVector) {
    left = left - right
}
public func * (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}
public func *= (left: inout CGVector, right: CGVector) {
    left = left * right
}
public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}
public func *= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector * scalar
}
public func / (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}
public func /= (left: inout CGVector, right: CGVector) {
    left = left / right
}
public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}
public func /= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector / scalar
}
