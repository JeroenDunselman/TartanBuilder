import Foundation
import UIKit

public class Palet {
//  let colorEnum = ["B", "R", "G", "P", "K", "W", "LR", "T", "Y", "DB", "DG", "NB", "WR", "A", "N", "LB", "Restricted", "H", "C", "S", "LDR", "LG", "B R"]
  
  public var clrs : [UIColor]
  public var clrCodes : [String] = []

//"LR","DB", "DG", "NB", "WR", "A", , "LB", "Restricted", "H", "C", "S", "LDR", "LG", "B R"
  
  public init(numClrs: Int) {
    clrs = [(UIColor.black)]
    clrCodes.append("K")
    clrs.append(UIColor.blue)
    clrCodes.append("B")
    clrs.append(UIColor.red)
    clrCodes.append("R")
    clrs.append(UIColor.green)
    clrCodes.append("G")
    clrs.append(UIColor.yellow)
    clrCodes.append("Y")
    clrs.append(UIColor.gray)
    clrCodes.append("N")
    clrs.append(UIColor.purple)
    clrCodes.append("P")
    clrs.append(UIColor.brown)
    clrCodes.append("T")
    clrs.append(UIColor.white)
    clrCodes.append("W")
    //  random/guessing
    clrs.append(UIColor.darkGray)
    clrCodes.append("DG")
    clrs.append(UIColor.lightGray)
    clrCodes.append("C")
    clrs.append(UIColor.cyan)
    clrCodes.append("S")
    clrs.append(UIColor.magenta)
    clrCodes.append("A")
    clrs.append(UIColor.orange)
    clrCodes.append("H")
  }
  
}

public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}


