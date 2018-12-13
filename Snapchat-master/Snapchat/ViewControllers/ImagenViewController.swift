//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by Jordan Revata Cuela on 31/10/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVFoundation

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    var audioID = NSUUID().uuidString
    var audioURL : String = ""
    var audioRecorder : AVAudioRecorder?
    var audioURLLocal : URL?
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
        
    }
    
    
    func setupRecorder(){
        do{
           
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            
            let basePath : String  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponentes = [basePath , "audio.m4a"]
            let audioURL2 = NSURL.fileURL(withPathComponents: pathComponentes)
            
            var settings  : [String:AnyObject]  = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            audioRecorder = try AVAudioRecorder(url: audioURL2!, settings: settings)
            audioRecorder!.prepareToRecord()
            self.audioURLLocal = audioURL2
            
        }catch let error as NSError{
            print(error)
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording{
            audioRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
        }else{
            audioRecorder?.record()
            recordButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOf : audioURLLocal!)
            audioPlayer?.play()
        }catch{}
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        let imagenesFolder = FIRStorage.storage().reference().child("imagenes")
        let imagenData = UIImageJPEGRepresentation(imageView.image! , 0.1)!
        
        imagenesFolder.child("\(imagenID).jpg").put(imagenData, metadata: nil, completion: {(metadata, error) in
            print("Intentando subir la imagen")
            if error != nil {
                print("Ocurrio un error: \(String(describing: error))")
            }else{
                
                
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: metadata?.downloadURL()?.absoluteString);
                

            }
        })
        
        let audiosFolder = FIRStorage.storage().reference().child("audios")
        audiosFolder.child("\(audioID).m4a").putFile(audioURLLocal!, metadata: nil, completion: {(metadata, error) in
            if error != nil{
                print(error!)
            }else{
                self.audioURL = (metadata?.downloadURL()?.absoluteString)!
            }
        })
        
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.descrip = descripcionTextField.text!
        siguienteVC.imagenID = imagenID
        siguienteVC.audioID = audioID
        siguienteVC.audioURL = audioURL
    }
   

}
