

import UIKit

class RotateZoomImageView: UIImageView, UIGestureRecognizerDelegate {
 
    var previousLocation = CGPoint.zero
    
    override init(image: UIImage!) {
        super.init(image: image)
        self.initialSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    func initialSetup() {
        self.isUserInteractionEnabled = true
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(RotateZoomImageView.handleRotation(_:)))
        rotationRecognizer.delegate = self
        self.addGestureRecognizer(rotationRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(RotateZoomImageView.handlePan(_:)))
        panRecognizer.delegate = self
        self.addGestureRecognizer(panRecognizer)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(RotateZoomImageView.handlePinch(_:)))
        pinchRecognizer.delegate = self
        self.addGestureRecognizer(pinchRecognizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        previousLocation = self.center
    }
    
    func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        gesture.view!.transform = gesture.view!.transform.rotated(by: gesture.rotation);
        gesture.rotation = 0;
    }
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview!)
        let newPosition = CGPoint(x: previousLocation.x + translation.x, y: previousLocation.y + translation.y)
        self.center = newPosition
    }
    
    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        gesture.view!.transform = gesture.view!.transform.scaledBy(x: gesture.scale, y: gesture.scale);
        gesture.scale = 1;
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
