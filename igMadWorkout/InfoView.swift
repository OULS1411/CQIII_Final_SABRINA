// ============================
//====================
import UIKit
// ============================
class InfoView: UIViewController
{
    // ============================
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var reorderButton: UIButton!
    var theDatabase: [String : [[String : String]]]!
    var theWorkout: [String]!
    // ============================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
        self.infoDateLabel.text = self.getDates()[Shared.sharedInstance.theRow]
        self.theWorkout = self.fillUpWorkoutArray(self.infoDateLabel.text!)
    }
    // ============================ Fonction pour changer le texte du bouton
    @IBAction func reorder(_ sender: UIButton) {
        if !self.theTableView.isEditing {
            self.theTableView.isEditing = true
            self.reorderButton.setTitle("DONE", for: UIControlState())
        } else {
            self.theTableView.isEditing = false
            self.reorderButton.setTitle("EDIT", for: UIControlState())
        }
    }
    // ============================  Fonction qui recupere un element du dictionnaire pour en faire un Array en fonction de la clé envoyer en parametre
    func fillUpWorkoutArray(_ theDate: String) -> [String] {
        var arrToReturn: [String] = []
        
        for (a, b) in self.theDatabase {
            if a == theDate {
                for c in b {
                    for (d, e) in c {
                        arrToReturn.append("[\(e)] : \(d)")
                    }
                }
            }
        }
        return arrToReturn
    }
    // ============================ Fonction pour supprimer un element du dictionnaire
    func deleteFromDatabase(_ theDate: String, indexToDelete: Int) {
        for (a, b) in self.theDatabase {
            if a == theDate {
                for _ in b {
                    self.theDatabase[theDate]?.remove(at: indexToDelete)
                    Shared.sharedInstance.saveDatabase(self.theDatabase)
                    return
                }
            }
        }
    }
    // ============================ Recuperer les dates du dictionnaire
    func getDates() -> [String] {
        var tempArray = [""]
        for (a, _) in  self.theDatabase {
            tempArray.append(a)
        }
        tempArray.remove(at: 0)
        return tempArray
    }
    // ============================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // ============================ Fonction qui retourne nombre rangées de la tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.theTableView.backgroundColor = UIColor.clear
        return self.theWorkout.count
    }
    // ============================ Fonction qui remplie la tableView
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 14.0)
        cell.textLabel!.text = self.theWorkout[indexPath.row]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    // ============================  Fonction qui  permet d'activer la possibilité de supprimé la rangé
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.theWorkout.remove(at: indexPath.row)
            self.deleteFromDatabase(self.infoDateLabel.text!, indexToDelete: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    // ============================ Fonction qui permet de déplacé vers un autre emplacement dans la vue de la table; on met "true"si la ligne peut être déplacée
    func tableView(_ tableView: UITableView, canMoveRowAtIndexPath indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    // ============================ Fonction qui permet de déplacer une ligne à un emplacement spécifique dans la vue de la table vers un autre emplacement
    func tableView(_ tableView: UITableView, moveRowAtIndexPath fromIndexPath: IndexPath, toIndexPath: IndexPath)
    {
        let itemToMove = self.theDatabase[self.infoDateLabel.text!]?[fromIndexPath.row]
        self.theDatabase[self.infoDateLabel.text!]?.remove(at: fromIndexPath.row)
        self.theDatabase[self.infoDateLabel.text!]?.insert(itemToMove!, at: toIndexPath.row)
        Shared.sharedInstance.saveDatabase(self.theDatabase)
    }
    // ============================
}





















