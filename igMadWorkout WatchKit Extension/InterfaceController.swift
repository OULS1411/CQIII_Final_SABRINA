//======================================================
import WatchKit
import Foundation
import WatchConnectivity
//======================================================
class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //--------------------------------------------------
    @IBOutlet var table: WKInterfaceTable!
  
    //-----------
    var data: [String : String] = [:]
    var dates: [String] = []
    var workouts: [String] = []
    
     //-----------
    var session : WCSession!
    //----------- Function de gestion des UserDefaults
    func userDefaultManager() {
    //s'il ne trouve rien il set quelque chose sinon data va recevoir se qu'il va trouvé dans les UserDefaults qui va etre un dictionnaire
        if UserDefaults.standard.object(forKey: "data") == nil{
        UserDefaults.standard.set(data, forKey: "data")
        }else {
            data = UserDefaults.standard.object(forKey: "data") as! [String : String]
        }
    }
    //-----------
    func tableRefresh() {
        table.setNumberOfRows(data.count, withRowType: "row")
        for index in 0..<table.numberOfRows {
            let row = table.rowController(at: index) as! TableRowController //la rangé de ma table doit étre controller par ma classe TableRowController
            row.dates.setText(dates[index]) // chercher toutes les dates qui se trouve dans le table dates
        }
    }
    
    //--------------------------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    //--------------------------------------------------
    override func willActivate() {
        //-----------
        super.willActivate()
        //-----------
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        //-----------
        //------------
        userDefaultManager() //une fois l'application s'execute il fait la gestion des userDefault
        //------------
        self.dates = Array(data.keys)
        self.workouts = Array(data.values)
        tableRefresh()
    }
    //--------------------------------------------------
    override func didDeactivate() {
        super.didDeactivate()
    }
    //--------------------------------------------------

    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    //-------------------------------------------------- La montre reçoit le message
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //-----------
        // Message du téléphone
        // revoit la valeur de la clé  "Message" convertit si possible en dictionnaire
        let value = message["Message"] as? [String : String]
        //-----------
        DispatchQueue.main.async{ () -> Void in
            self.data = value!
            UserDefaults.standard.set(self.data, forKey: "data") //sauvegarder dans userDefaults
            self.dates = Array(value!.keys)
            self.workouts = Array(value!.values) // convertir les valeurs du dictionnaire a un tableau
            self.tableRefresh()
   
            
        }
        //-----------
        //  replyHandler(["Message" : conversation])
        //-----------
    } 
    //----------- Quand je clique sur une rangé je me rend a une autre interface pages2 et j'envoi l'information
    
    
    override func table (_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int){
        self.pushController(withName: "page2", context: ["workout" : workouts[rowIndex]])
    }
   

}
//======================================================









