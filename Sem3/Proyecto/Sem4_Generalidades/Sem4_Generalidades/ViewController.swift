//
//  ViewController.swift
//  Sem4_Generalidades
//
//  Created by Fernanda Alvarado on 5/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelTitulo: UILabel!
    
    var objetoMazda3:Mazda3Mini?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       labelTitulo.text="Vamos por la 14"
    }
   
    @IBAction func crearObjeto(_ sender: UIButton) {
    objetoMazda3 = Mazda3Mini(carga: 50, tamanio: "Pequeño", puertas: 4, color: "Rojo", precio: "15000USD")
        print("El objeto fue creado")
    }
    @IBAction func encender(_ sender: UIButton) {
    objetoMazda3?.encender()
    }
    @IBAction func apagar(_ sender: UIButton) {
    objetoMazda3?.acelerar()
    }
    @IBAction func recargar(_ sender: UIButton) {
    
    objetoMazda3?.recargar()
        
    }
    @IBAction func mostrarPropiedades(_ sender: UIButton) {
        print("El carro Mazda 3 es de tamaño \(objetoMazda3!.tamanio)")
        print("Tiene \(objetoMazda3!.puertas) puertas")
        print("Su color es: \(objetoMazda3!.color)")
        print("Su precio es de \(objetoMazda3!.precio) dolares")
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


