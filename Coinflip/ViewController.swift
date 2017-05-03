//
//  ViewController.swift
//  Coinflip
//
//  Created by Cale Woodley on 28/4/17.
//  Copyright © 2017 Cale Woodley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var currentValue: Int = 0
  var coins = 0
  var wagerMax = 0

  var currentWager = 0
  var coinHeads: Int = 1
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var coinsLabel: UILabel!
  @IBOutlet weak var wagerLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    coins = 1 + Int(arc4random_uniform(10000))
    setCoins()
    setWager()
  }
  
  func setWager() {
    if (coins <= 10) {
      currentWager = Int(10)
      wagerLabel.text = String(10)
      slider.minimumValue = Float(10)
      slider.maximumValue = Float(10)
      slider.value = Float(10)
      
    } else {
      let wagerHalf =  Double(coins) * 0.5
      currentWager = Int(wagerHalf)
      wagerLabel.text = String(currentWager)
      slider.minimumValue = Float(10)
      slider.maximumValue = Float(coins)
      slider.value = Float(wagerHalf)
    }

  }
  
  func setCoins() {
    coinsLabel.text = String(coins)
    slider.maximumValue = Float(coins)
    wagerMax = coins
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showAlert(title: String, coinSide: String) {
    let message = "The coin landed \(coinSide) side up."
    
    var confirmText = String()
    
    if (coinSide == "Tails") {
      confirmText = "Boooooo!"
    } else {
      confirmText = "Nice"
    }
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: confirmText,
                               style: .default,
                               handler: {
                                action in
                                self.setCoins()
                                self.setWager()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)


  }
  
  @IBAction func PerformFlipCoin() {
    let flipCoin = Int(arc4random_uniform(UInt32(2)) + UInt32(0))
    
    var title = "You win!"
    var coinSide = "Heads"
    
    if flipCoin == 1 {
      print("You won!")
      let newCoins = (coins + currentWager)
      coins = newCoins
      
    } else {
      title = "You lose"
      coinSide = "Tails"
      let newCoins = (wagerMax - currentWager)
      
      if (newCoins <= 10) {
        coins = 10
      } else {
        coins = Int(newCoins)
      }
      
      // =debug
      //print("You lost \(currentWager) from \(wagerMax) coins. \(newCoins) coins remain.")
    }
    
    showAlert(title: title, coinSide: coinSide)
  }
  

  
  @IBAction func sliderMoved(_ slider: UISlider) {
    currentWager = lroundf(slider.value)
    wagerLabel.text = String(currentWager)
//    print("\(currentWager)")
  }
  
  @IBAction func resetGame() {
    coins = 1 + Int(arc4random_uniform(10000))
    setCoins()
    setWager()
  }


}
