import UIKit

struct TartanDefStore {
  public let tartanDefs:[Tartan]?
  
  static func defaultTartans() -> [Tartan] {
    return parseTartanDefs()
  }
  
  fileprivate static func parseTartanDicts() -> [[String]] {
    let path = Bundle.main.path(forResource: "tartandefs elements as row", ofType: "rtf")
    
    let contents: NSString
    do {
      contents = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
    } catch _ {
      contents = ""
    }

    let array = contents.components(separatedBy: "\n");
    //    print(array)
    let tartans:[String] = array.reduce([]) {
      (result, zone) in result +
        [zone.replacingOccurrences(of: "\\", with: "")]
    }
    var arNames:[String] = []
    for i in stride(from: 9, through: 2307, by: 3) {
      arNames.append(tartans[i])
      //      print(tartans[i])
    }
    var arDefs:[String] = []
    for i in stride(from: 11, through: 2306, by: 3) {
      arDefs.append(tartans[i])
      //      print(zoneClrs[i])
    }

    var tartanAr:[[String]] = []
    for i in 0..<arDefs.count {
      var myDict:[String] = []
      myDict.append(arNames[i]) //, arDefs[i]))
      myDict.append(arDefs[i])
      tartanAr.append(myDict)
    }
    //    print(tartanAr)
    print("lib loaded")
    return tartanAr // as! [[String]]
    
  }
 
  fileprivate static func parseTartanDefs() -> [Tartan] {
    let tartanDict = parseTartanDicts() as [[String]]!
    var result:[Tartan] = []

    let names = tartanDict?.reduce([]) {
      (ar:[String], el:[String]) -> [String] in
      ar + [el[0]]
    }
    
    let defs = tartanDict?.reduce([]) {
      (ar:[String], el:[String]) -> [String] in
      ar + [el[1]]
    }
    
    for i in 0..<defs!.count {
      let defString =   (defs?[i])!
      let zonesArray = defString.components(separatedBy: ",")
//      print(defAr)

//**clrs
      let zoneColors:[String] = zonesArray.reduce([]) {
        (result, zone) in result +
          [zone.components(separatedBy: CharacterSet.decimalDigits).joined(separator: "").trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\t", with: "")]}
//      print(zoneColors)
      
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
      var zoneLengths:[Int]
      if let zoneLens = lenghtComponents as? [Int] {
        zoneLengths = zoneLens
      } else {
        zoneLengths = []
      }    
//      print(zoneLengths)
      let size = zoneLengths.reduce(0, +)
      
      func lengthsInSet(lengths:[Int]) -> [Int] {
        let uniqueLengths:[Int] = lengths.reduce([], { (a: [Int], b: Int) -> [Int] in
          if a.contains(b)  {
            return a
          } else {
            return a + [b]
          }
        })
        return uniqueLengths
      }
      let lengthSet = lengthsInSet(lengths:zoneLengths)
      
      result.append(Tartan(
        name: (names?[i])!,
        id: "",
        definition: defString,
        zoneColorCodes: zoneColors,
        zoneLengths: zoneLengths,
        size: size,
        colorSet: colorSet,
        lengthSet: lengthSet,
        palet: nil
      ))
    }
    
    return result
  }
}
