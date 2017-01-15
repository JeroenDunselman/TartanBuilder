//
//  ImageViewController.swift

//  Created by Jeroen Dunselman on 03/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

//  let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleTap))
     var myImgVw = UIImageView()
  
  override func loadView() {
    // UI
    
    let view = UIView()
//    view.backgroundColor = .orange
    
    //
    //    let image = UIImage(named: "Apple.jpg")
    //    let myImgVw = UIImageView(image: image)
    
    //
//    let checkerboard = Checkerboard()
//    print(checkerboard)
    //
    let myImgVw = UIImageView()
//    myImgVw.image = checkerboard.tartanImg
//    
//    view.addSubview(myImgVw)
//    
    // Layout
    
    myImgVw.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      myImgVw.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      myImgVw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
      ])
    
    self.view = view
//    print("LOADED")
  }
  public func handleTap() {
    //    performSegue(withIdentifier: revealSequeId, sender: nil)
    self.loadView()
    addGestureRecognizer()
//    print("handled")
  }
  
  func addGestureRecognizer(){
    //    self.view.addGestureRecognizer(swipeRecognizer)
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleTap))
    swipeRight.direction = UISwipeGestureRecognizerDirection.right
    self.view.addGestureRecognizer(swipeRight)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleTap))
    swipeDown.direction = UISwipeGestureRecognizerDirection.down
    self.view.addGestureRecognizer(swipeDown)
  }
  /*
   http://stackoverflow.com/questions/24215117/how-to-recognize-swipe-in-all-4-directions
   override func viewDidLoad() {
   super.viewDidLoad()
   
   let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
   swipeRight.direction = UISwipeGestureRecognizerDirection.right
   self.view.addGestureRecognizer(swipeRight)
   
   let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
   swipeDown.direction = UISwipeGestureRecognizerDirection.down
   self.view.addGestureRecognizer(swipeDown)
   }
   
   func respondToSwipeGesture(gesture: UIGestureRecognizer) {
   if let swipeGesture = gesture as? UISwipeGestureRecognizer {
   switch swipeGesture.direction {
   case UISwipeGestureRecognizerDirection.right:
   print("Swiped right")
   case UISwipeGestureRecognizerDirection.down:
   print("Swiped down")
   case UISwipeGestureRecognizerDirection.left:
   print("Swiped left")
   case UISwipeGestureRecognizerDirection.up:
   print("Swiped up")
   default:
   break
   }
   }
   }*/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //
    self.addGestureRecognizer()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
