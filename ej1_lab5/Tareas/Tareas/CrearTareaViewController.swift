//
//  CrearTareaViewController.swift
//  Tareas
//
//  Created by Fernanda Alvarado on 12/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class CrearTareaViewController: UIViewController {

    @IBOutlet weak var swImportante: UISwitch!
    @IBOutlet weak var txtNombreTarea: UITextField!
    var anteriorVC = ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func agregar(_ sender: Any) {
    let tarea = Tarea()
        tarea.nombre = txtNombreTarea.text!
        tarea.importante = swImportante.isOn
        anteriorVC.tareas.append(tarea)
        anteriorVC.tableView.reloadData()
        navigationController!.popViewController(animated: true)
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
