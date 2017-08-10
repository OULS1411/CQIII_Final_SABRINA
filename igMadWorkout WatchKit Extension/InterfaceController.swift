//======================================================
import WatchKit
import Foundation
import WatchConnectivity
//======================================================
class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //--------------------------------------------------
    @IBOutlet var messageLabel: WKInterfaceLabel!
    @IBOutlet var sendButton: WKInterfaceButton!
    //-----------
    var session : WCSession!
    //-----------
    var conversation: String = ""
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
    }
    //--------------------------------------------------
    override func didDeactivate() {
        super.didDeactivate()
    }
    //--------------------------------------------------
//    @IBAction func sendToParent() {
//        sendMessage()
//    }
    //--------------------------------------------------
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    //--------------------------------------------------
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //-----------
        // Message du téléphone
        let value = message["Message"] as? String // "Message" c'est la clé
        conversation += value! //il va accumuler la conversation
        //-----------
        DispatchQueue.main.async { () -> Void in
            // Affichage sur montre
            self.messageLabel.setText(self.conversation) //(.setText) non pas (.text)  qui affiche la
        }
        //-----------
        replyHandler(["Message" : conversation]) // elle envoi le dic (envoi toute la conversation )
        //-----------
    }
    //--------------------------------------------------
//    func sendMessage() {
//        presentTextInputController(withSuggestions: ["Bonjour"], allowedInputMode: WKTextInputMode.plain,
//                                   completion: {(results) -> Void in
//                                    if results != nil && results!.count > 0 {
//                                        let aResult = results?[0] as? String
//                                        self.conversation += "Watch : \(aResult!)\n\n"
//                                        self.messageLabel.setText(self.conversation)
//                                        self.session.sendMessage(["Message" : self.conversation],
//                                                                 replyHandler: {replyMessage in}, errorHandler: {error in print(error)})
//                                    }
//        })
//    }
    //--------------------------------------------------
}
//======================================================









