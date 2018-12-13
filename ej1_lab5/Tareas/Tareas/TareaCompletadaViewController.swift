//
//  TareaCompletadaViewController.swift
//  Tareas
//
//  Created by Fernanda Alvarado on 12/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class TareaCompletadaViewController: UIViewController {
    var tarea=Tarea()
    var anteriorVC = ViewController()
    @IBOutlet weak var tareaLabel: UILabel!
    
    @IBAction func completarTarea(_ sender: Any) {
    anteriorVC.tareas.remove(at: anteriorVC.indexSeleccionado!)
        anteriorVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if tarea.importante{
            tareaLabel.text = "🙀\(tarea.nombre)"
        }else {
            tareaLabel.text = tarea.nombre
        }
        
        // Do any additional setup after loading the view.
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
