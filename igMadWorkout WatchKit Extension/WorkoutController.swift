//====================
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
        
}//end class



