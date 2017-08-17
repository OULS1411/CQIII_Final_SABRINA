//
//  WorkoutController.swift
//  igMadWorkout
//
//  Created by Sabrina Ouldyounes on 17-08-15.
//  Copyright © 2017 Sabrina Ouldyounes. All rights reserved.
//

import Foundation
import WatchKit
//=============================
class WorkoutController: WKInterfaceController {
    
    @IBOutlet var displayLabel: WKInterfaceLabel!
   
    
    //------------------------- reçoit le dictionnaire
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        let temp = context as? [String : String]
        displayLabel.setText(temp?["workout"])
    }
    //    override func willActivate() {
    //        super.willActivate()
    //    }
    //    override func didDeactivate() {
    //        super.didDeactivate()
    //    }
    
}//end class



