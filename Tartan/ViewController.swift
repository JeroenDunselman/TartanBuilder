//
//  ViewController.swift
//  Tartan
//
//  Created by Jeroen Dunselman on 04/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextViewDelegate {
  
  var progressView: UIProgressView?
  var progressLabel: UILabel?

  @IBOutlet weak var definitionText: UITextView!
  @IBOutlet weak var activityVw: UIActivityIndicatorView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var imgVw: UIImageView!

  var tartanDefs:[Tartan]?
  let palet = Palet(numClrs: 8)
  
  var imageForSwipeDown = UIImage()
  var imageMain = UIImage()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    definitionText.returnKeyType = UIReturnKeyType.done
    self.definitionText.delegate = self
    
    showRoyalStewart()
    
    tartanDefs = TartanDefStore.defaultTartans()
    //    .filter{$0.definition != "Restricted"}
    //    .filter{$0.size < 150}.filter{$0.size > 100}
    //    .filter{$0.name.contains("MacFadzean")}.filter{$0.size > 150}
    //    .filter{$0.zoneLengths.count == 15}//store existing lengths

    print("Showing \(tartanDefs?.count)")
    
    addParallaxToView(vw:imgVw)
    self.addGestureRecognizer()
    
    activityVw.hidesWhenStopped = true
    
  }
  
  public func swipeRight() {

    self.definitionText.resignFirstResponder()
    imgVw.image = imageForSwipeDown
    
    //get random next def from library
    let libraryIndex = Int({
      return CGFloat(Int(arc4random_uniform(UInt32(
        (tartanDefs?.count)!))))}())
    let nextTartan = tartanDefs?[libraryIndex]
    
    print("Showing next random: \(nextTartan?.name)")
    showTartan(tartan: nextTartan!)

    label.text = " ..." + (nextTartan?.name)!

    if (nextTartan?.zoneLengths) == nil {
      swipeRight()
    }
  }
  
  public func swipeDown() {
    self.definitionText.resignFirstResponder()
    imgVw.image = imageForSwipeDown
  }

  func queueTartan(tartan: Tartan){
    let tartanBuild = Checkerboard(
      tartan: tartan,
      sq:600,
      zPattern:ZPattern(length:3), palet:palet)
    
    if let result = tartanBuild.tartanImgResult as Array! {
      if result.count > 0 {
        if let theTartanImage = result[0] as UIImage! {
          self.imageMain = theTartanImage
        }
      }
      if result.count > 1 {
        if let theTartanRandomColorImage = result[1] as UIImage! {
          self.imageForSwipeDown = theTartanRandomColorImage
        }
      }
    }
   
    DispatchQueue.main.async {
      () -> Void in
      self.activityVw.stopAnimating()
      self.imgVw.image = self.imageMain
      self.label.text = tartan.name
      self.view.setNeedsDisplay()
  
    }
  }

  func showTartan(tartan: Tartan) {
    definitionText.text = tartan.definition
   
    self.activityVw.startAnimating()
    DispatchQueue.global(qos: .background).async {
        self.queueTartan(tartan: tartan)
    }
  }
  
  func createCustomTartan(fromDefinition:String) -> Tartan{
    let tartan:[Tartan] = [Tartan(
      name: "Custom",
      id: "",
      definition: fromDefinition,
      zoneColorCodes: [],
      zoneLengths: [],
      size: 0,
      colorSet: [],
      lengthSet: [],
      palet: nil
    )]

    let result:[Tartan] = tartan[0].getDefinition()
    return result[0]
  }

  func showCustom(withDefinition: String) {
    var nextTartan = createCustomTartan(fromDefinition:withDefinition)
    nextTartan.name = "Custom"
    showTartan(tartan: nextTartan)
  }
  
  func showRoyalStewart() {
    let stewart = "R72, B8, K12, Y2, K2, W2, K2, G16, R8, K2, R4, W2, R4, K2, R8, G16, K2, W2, K2, Y2, K12, B8"
    label.text = "...Royal Westwood"
    definitionText.text = stewart
    self.view.setNeedsDisplay()
    var nextTartan = createCustomTartan(fromDefinition:stewart)
    nextTartan.name = "Royal Westwood"
    showTartan(tartan: nextTartan)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //trigger custom build from return key
    var result = false
    
    if(text == "\n") {
      view.endEditing(true)
      
      definitionText.endEditing(true)
      let newDefinition:String = definitionText.text
      
      label.text = "...Custom"
      showCustom(withDefinition:newDefinition)
      result = false
    } else {
      result = true
    }
    return result
  }
  
  func addGestureRecognizer(){
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
    swipeRight.direction = UISwipeGestureRecognizerDirection.right
    self.view.addGestureRecognizer(swipeRight)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown))
    swipeDown.direction = UISwipeGestureRecognizerDirection.down
    self.view.addGestureRecognizer(swipeDown)
  }
  
  func addParallaxToView(vw: UIView) {
    let amount = 25
    
    let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    horizontal.minimumRelativeValue = -amount
    horizontal.maximumRelativeValue = amount
    
    let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
    vertical.minimumRelativeValue = -amount
    vertical.maximumRelativeValue = amount
    
    let group = UIMotionEffectGroup()
    group.motionEffects = [horizontal, vertical]
    vw.addMotionEffect(group)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

