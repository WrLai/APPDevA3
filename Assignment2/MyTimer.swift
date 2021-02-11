//
//  MyTimer.swift
//  Assignment2 & 3
//
//

import Foundation

protocol MyTimerDelegate {
    func timeChanged (time: Int)
    func nextQuote()
}


class MyTimer {
    var delegate: MyTimerDelegate?
    var initialTime: Int = 5
    var currentTime: Int = 5
    var timer: Timer?
    
    func setInitialTime(_ initTime: Int) {
        initialTime = initTime
    }
    
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: handleTick)
    }
    
   
    
    func handleTick (timer: Timer){
        currentTime = currentTime - 1
        print("this is \(currentTime)")
        delegate?.timeChanged(time: currentTime)
        if currentTime == 0{
            // not sure if it should start at the selected number
            // so I incremented 1
            currentTime = initialTime + 1
            //should've used it in the viewcontroller class, but I got lazy :(
            delegate?.nextQuote()
        }
    }
    
    //not gonna use it
    func stop(){
        timer?.invalidate()
    }
    
    // use it for reseting the timer as the slider slides
    func reset(){
        if currentTime != initialTime{
            delegate?.timeChanged(time: initialTime)
        }
        currentTime = initialTime
    }
    
}
