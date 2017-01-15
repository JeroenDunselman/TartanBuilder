//
//  Checkerboard.swift

//  Created by Jeroen Dunselman on 03/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reservedvar/

import Foundation
import UIKit

struct Checkerboard {
  typealias Coordinate = (x: Int, y: Int)
  
//  fileprivate var squares: [[Square]] = [[]]
  fileprivate var cells: [[Int]] = [[]]
  public var tartanImgResult: [UIImage] = []
  public let zoneLengths:[Int]
  public var zoneColors:[String]?
  
  init(tartan:Tartan,
       sq:Int,
       zPattern:ZPattern = ZPattern(length:3),
       palet:Palet = Palet(numClrs: 8)) {
    
//    cells = [[]] //->coords
    var tartanImg = UIImage()
    var tartanImg2 = UIImage()
    let zPat = zPattern
    
    zoneColors = tartan.zoneColorCodes
    
    if (tartan.zoneLengths?.count)! > 0
    {
      let size = 4*(tartan.zoneLengths.flatMap { $0.reduce(0, +) })!
      print("size:\(size)")
      print("definition:\(tartan.definition)")

      //get colors in def
      let clrs:[String] = tartan.colorSet!
      //      print(clrs)
      
      //create store [colorCode:[coordinates]]
      var clrDict: [String:[Coordinate]] = [:]
      for (_, element) in clrs.enumerated() {
                clrDict.updateValue([], forKey: element)}

      //get 2d def as single array of clrs
      let arrDef = tartan.zoneTartan().reduce([]) {
        (ar, el:TartanZone) in
        ar + Array(repeatElement(el.colorIndex, count: el.zoneSize))
      }
      
      //mirror 2d def
      let reversedArray = arrDef.reversed()
      let arr2D = arrDef + reversedArray
      
      //alternate colors using zPat
      var clr:Int = 0
      for x in 0..<arr2D.count {
        var row:[Int] = []
        for y in 0..<arr2D.count {
          let pos:Coordinate = Coordinate(x:x, y:y)
          clr = 0
          
          if zPat.getZBoolForPos(x: pos.x, y: pos.y) {
            if let _ = arr2D[x % arr2D.count] {
            clr = arr2D[x % arr2D.count]!
            }
          } else {
            if let _ = arr2D[y % arr2D.count] {
            clr = arr2D[y % arr2D.count]!
            }
          }
          row.append(clr)
        }
        cells.append(row)
      }
    
     //collect coordinates by color from [[cell]]
      for (color) in clrs {
        var posAr:[Coordinate] = []
        var theColorFilter:Int = 0
        
        if let colorExists = palet.clrCodes.index(of:color){
          theColorFilter = colorExists
        }
        
        for (x, elementX) in cells.enumerated() {
            for (y, elementY) in elementX.enumerated()  {
              if elementY != theColorFilter {continue}
                let pos:Coordinate = Coordinate(x:x, y:y)
                posAr.append(pos)
            }
          }
        
        clrDict.updateValue(posAr, forKey: color)
      }
      
      //create 2 images
      tartanImg = UIImage(
        size: CGSize(width: size, height: size),
        palet: palet,
        randomPalet: false,
        dictShapes: clrDict
        )!
      tartanImg2 = UIImage(
        size: CGSize(width: size, height: size),
        palet: palet,
        randomPalet: true,
        dictShapes: clrDict
        )!
      print(tartan.name)
      
      zoneLengths = tartan.zoneLengths!
      tartanImgResult.append(tartanImg)
      tartanImgResult.append(tartanImg2)
      
    }
    else {
      zoneLengths = []
      tartanImg = UIImage(color: UIColor.lightGray)!
      tartanImg2 = UIImage(color: UIColor.lightGray)!
    }
  }
}
