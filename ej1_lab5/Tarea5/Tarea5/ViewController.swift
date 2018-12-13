//
//  ViewController.swift
//  Tareas
//
//  Created by Fernanda Alvarado on 12/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var tareas:[Tarea] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //tareas = crearTareas()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.lightGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
      obtenerTareas()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let tarea = tareas[indexPath.row]
        let prom = (tarea.laboratorios+tarea.examen+tarea.practicas)/3
      
        if prom<13{
            cell.textLabel?.text = "☠️ \(tarea.nombre!)"
            cell.backgroundColor = UIColor.red
        }else if prom<21{
            cell.textLabel?.text = "🎉 \(tarea.nombre!)"
             cell.backgroundColor = UIColor.green
        }else{
            cell.textLabel?.text = "Promedio incorrecto"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tarea = tareas[indexPath.row]
        performSegue(withIdentifier: "tareaSeleccionadaSegue", sender: tarea)
    }
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.red
    }*/
    /* func crearTareas() -> [Tarea]{
        let tarea1 = Tarea()
        tarea1.nombre = "Pasear al perro"
        tarea1.importante = false
        let tarea2 = Tarea()
        tarea2.nombre = "Comprar verduras"
        tarea2.importante = true
        let tarea3 = Tarea()
        tarea3.nombre = "Lavar los servicios"
        tarea3.importante = false
        return [tarea1,tarea2,tarea3]
    }*/
    @IBAction func agregarTarea(_ sender: Any) {
     performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
    func obtenerTareas(){
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tareas = try context.fetch(Tarea.fetchRequest()) as! [Tarea]
        } catch{
            print("HA OCURRIDO UN ERROR")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        if segue.identifier == "tareaSeleccionadaSegue"{
            let siguienteVC = segue.destination as! TareaCompleadaViewController
            siguienteVC.tarea = sender as? Tarea
            
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let tarea = tareas.remove(at: indexPath.row)
        context.delete(tarea)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        tableView.reloadData()
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
}

