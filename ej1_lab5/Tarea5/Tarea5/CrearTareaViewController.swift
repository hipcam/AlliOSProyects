//
//  CrearTareaViewController.swift
//  Tarea5
//
//  Created by Fernanda Alvarado on 17/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class CrearTareaViewController: UIViewController {

    @IBOutlet weak var txtExmFinal: UITextField!
    @IBOutlet weak var txtPromLabs: UITextField!
    @IBOutlet weak var txtPromPract: UITextField!
    @IBOutlet weak var txtNombreTarea: UITextField!
    @IBOutlet weak var swImportante: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func agregar(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let tarea = Tarea(context: context)
        tarea.nombre = txtNombreTarea.text!
        tarea.examen = Double(txtExmFinal.text!)!
        tarea.laboratorios = Double(txtPromLabs.text!)!
        tarea.practicas = Double(txtPromLabs.text!)!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
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

