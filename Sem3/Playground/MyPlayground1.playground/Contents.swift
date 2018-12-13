//: Playground - noun: a place where people can play

import UIKit

class Persona{
    var nom:String="Fernanda"
    var edad:Int=19
    var colorCamisa:String=""
    var color=Colores()
    func saludo() -> String {
        colorCamisa=color.colorAzul
        return "Mi nombre es \(nom) y mi edad es \(edad) años y mi camisa es de color \(colorCamisa)"
    }
}
class Colores{
    var colorAzul:String="Blanca"
    var colorRojo:String="Rojo"
}
var objPersona=Persona()
objPersona.saludo()

