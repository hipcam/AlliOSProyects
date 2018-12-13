//
//  Mazda3.swift
//  Sem4_Generalidades
//
//  Created by Fernanda Alvarado on 5/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import Foundation
class Mazda3 {
    var tamanio:String
    var puertas:Int
    var color:String
    var precio:String
   

init(tamanio:String,puertas:Int,color:String,precio:String) {
        self.tamanio=tamanio
        self.puertas=puertas
        self.color=color
        self.precio=precio
    
    }
    init(){
        self.tamanio="S/T"
        self.color="S/C"
        self.puertas=2
        self.precio="$"
       
    }
    func encender() {
        print("Se encendiò el Mazda3")
    }
    func acelerar() {
        
    }
}
