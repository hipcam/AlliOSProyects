//
//  Mazda3Mini.swift
//  Sem4_Generalidades
//
//  Created by Fernanda Alvarado on 5/09/18.
//  Copyright © 2018 Fernanda Alvarado. All rights reserved.
//

import Foundation
class Mazda3Mini: Mazda3 {
    var carga: Int=57
init(carga:Int,tamanio:String,puertas:Int,color:String,precio:String) {
    super.init(tamanio:tamanio,puertas:puertas,color:color,precio:precio)
    self.carga=carga
    }
    func recargar() {
        carga=100
    }
    override func encender() {
        print("Se encendiò el Mazda3 Mini")
    }
}
