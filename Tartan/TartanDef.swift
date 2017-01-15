
import UIKit
typealias Coordinate = (x: Int, y: Int)
struct Tartan {
  var name: String
  let id: String
  let definition: String
  let zoneColorCodes: [String]
  let zoneLengths: [Int]?
  var size:Int?
  let colorSet: [String]?
  let lengthSet: [Int]?
  var palet: Palet?

  func getDefinition() -> [Tartan] {
    let zonesArray = definition.components(separatedBy: ",")
    let zoneColors:[String] = zonesArray.reduce([]) {
      (result, zone) in result +
        [zone.components(separatedBy: CharacterSet.decimalDigits).joined(separator: "").trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\t", with: "")]}
    
    //**colors used
    let colorSet = zoneColors.reduce([], { (a: [String], b: String) -> [String] in
      if a.contains(b) {
        return a
      } else {
        return a + [b]
      }
    })
    
    //**lengths
    let lenghtComponents = zonesArray.reduce([]) {
      (result, zone) in result +
        [Int(zone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: ""))]}
    let zoneLengths:[Int]
    var size = 0
    if let zoneLens = lenghtComponents as? [Int] {
      zoneLengths = zoneLens
      size = zoneLengths.reduce(0, +)
    } else {
      zoneLengths = []
    }
    
    return [Tartan(
      name: "",
      id: "",
      definition: definition,
      zoneColorCodes: zoneColors,
      zoneLengths: zoneLengths,
      size: size,
      colorSet: colorSet,
      lengthSet: [],
      palet: nil
      )]
  }
  
  func zoneTartan()-> [TartanZone] {
    var result:[TartanZone] = []

    //translate color code into palet position
    let defaultPalet = Palet(numClrs:0)
    let clrTable = colorSet!.map(
      {defaultPalet.clrCodes.index(of: $0)})

    for (index, element) in zoneColorCodes.enumerated() {
      var zoneColor = 0

      if let clrIndex = clrTable[(colorSet?.index(of:element))!]{
        zoneColor = clrIndex
      }
    
      result.append(TartanZone(
        colorCode:element,
        colorIndex:zoneColor,
        zoneSize:(zoneLengths?[index])!
      ))
    } 
    
    return result
  }
  
}

struct TartanZone {
  let colorCode:String
  let colorIndex:Int?
  let zoneSize:Int
}

struct colorShape {
  let colorCode:String
  var coordinates:[Coordinate]
}
