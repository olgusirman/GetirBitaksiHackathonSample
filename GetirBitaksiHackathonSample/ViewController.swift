//
//  ViewController.swift
//  GetirBitaksiHackathonSample
//
//  Created by Olgu Sirman on 18/03/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    lazy var participant: Participant = {
        let participant = Participant(name: "Olgu", email: "olgu.sir.man@gmail.com", gsm: "5374509059")
        return participant
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    @IBAction func drawElements(_ sender : UIButton) {
        
        //self.view.layer.sublayers?.removeAll()
        
        getElements(with: participant)
        
    }
    
    
}

enum DrawError : Error {
    case typeError
    case xPositionError
    case yPositionError
    case radiusError
    case colorError
    case widthError
    case heightError
}

//MARK: Helper
extension ViewController {
    
    func drawCircle(element : OSElements) throws {
        
        guard let type = element.type else { throw DrawError.typeError }
        
        if type == ElementType.circle.rawValue {
            
            guard let xPosition = element.xPosition else { throw DrawError.xPositionError }
            guard let yPosition = element.yPosition else { throw DrawError.yPositionError }
            guard let r = element.r else { throw DrawError.radiusError }
            guard let color = element.color else { throw DrawError.colorError }
            
            
            let circleLayer = CAShapeLayer()
            let center = CGPoint(x: xPosition, y: yPosition)
            
            circleLayer.path = UIBezierPath(arcCenter: center, radius: CGFloat(r), startAngle: 0, endAngle: 360, clockwise: true).cgPath
            circleLayer.fillColor = UIColor(hexString: color).cgColor
            self.view.layer.addSublayer(circleLayer)
            
        }
        
    }
    
    func drawRectangular(element : OSElements) throws {
        
        guard let type = element.type else { throw DrawError.typeError }
        
        if type == ElementType.rectangle.rawValue {
            
            guard let xPosition = element.xPosition else { throw DrawError.xPositionError }
            guard let yPosition = element.yPosition else { throw DrawError.yPositionError }
            guard let width = element.width else { throw DrawError.widthError }
            guard let height = element.height else { throw DrawError.heightError }
            guard let color = element.color else { throw DrawError.colorError }
            
            
            let rectLayer = CAShapeLayer()
            
            let rect = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            rectLayer.path = UIBezierPath(rect: rect).cgPath
            rectLayer.fillColor = UIColor(hexString: color).cgColor
            self.view.layer.addSublayer(rectLayer)
            
        }
        
    }
    
}

extension ViewController : APIManagerProtocol {
    
    func getElements(with participant : Participant) {
        
        APIManager.getElements(email: participant.email, name: participant.name, gsm: participant.gsm) { (base) in
            
            if let elements = base.elements {
                
                for element in elements {
                    try! self.drawCircle(element: element)
                    try! self.drawRectangular(element: element)
                }
                
            }
            
        }
        
    }
}

