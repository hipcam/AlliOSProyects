//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Jordan Revata Cuela on 26/10/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("usuarios").child((FIRAuth.auth()?.currentUser?.uid)!).child("snap").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            let snap = Snap()
            snap.id = snapshot.key
            snap.imagenURL  = ((snapshot.value as! Dictionary<String, Any>)["imagenURL"] as! String)
            snap.from       = ((snapshot.value as! Dictionary<String, Any>)["from"] as! String)
            snap.descrip    = ((snapshot.value as! Dictionary<String, Any>)["descripcion"] as! String)
            snap.imagenID   = ((snapshot.value as! Dictionary<String, Any>)["imagenID"] as! String)
            snap.audioID    = ((snapshot.value as! Dictionary<String, Any>)["audioID"] as! String)
            snap.audioURL   = ((snapshot.value as! Dictionary<String, Any>)["audioURL"] as! String)
            self.snaps.append(snap)
            self.tableView.reloadData()
        })
        
        FIRDatabase.database().reference().child("usuarios").child((FIRAuth.auth()?.currentUser?.uid)!).child("snap").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            var iterador = 0
            for snap in self.snaps{
                if snap.id == snapshot.key{
                    self.snaps.remove(at: iterador)
                }
                iterador+=1
            }
            self.tableView.reloadData()
        })
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0{
                return 1
        }else{
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count==0{
            cell.textLabel?.text = "No tienes SNAPS 😗"
        }
        else{
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
        }
        
        return cell
    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "camaraSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "verSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verSnapSegue"{
            let siguienteVC = segue.destination as! VerSnapViewController
            siguienteVC.snap = sender as! Snap
        }
    }
    
}
