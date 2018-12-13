//
//  TareaCompleadaViewController.swift
//  Tarea5
//
//  Created by Fernanda Alvarado on 17/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class TareaCompleadaViewController: UIViewController {

    
    var tarea : Tarea? = nil
    @IBOutlet weak var tareaLabel: UILabel!
    @IBOutlet weak var msjLabel: UILabel!
    @IBAction func completarTarea(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(tarea!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prom = ((tarea?.laboratorios)!+(tarea?.examen)!+(tarea?.practicas)!)/3
        if prom<13{
            tareaLabel.text = "☠️  \(tarea!.nombre!)"
            tareaLabel.backgroundColor = UIColor.red
            msjLabel.text = "Better luck next time buddy"
        }else if prom<21 {
            tareaLabel.text = "🎉 \(tarea!.nombre!)"
            tareaLabel.backgroundColor = UIColor.green
            msjLabel.text = "You're doing great, for now"
        }else{
            tareaLabel.text = "Promedio incorrecto"
            msjLabel.text = "Ingresa correctamente tus notas "
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

