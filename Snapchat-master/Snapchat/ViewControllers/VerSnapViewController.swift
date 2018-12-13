

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import AVFoundation
class VerSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    

    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    var player : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text? = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imagenURL), completed: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("usuarios").child((FIRAuth.auth()?.currentUser?.uid)!).child("snap").child(snap.id).removeValue()
        
            FIRStorage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete(completion: {(error) in
                print ("Se eliminó correctamente la imagen")
            })
        
            //Eliminar el audio del storage del proyecto de Firebaseq
            FIRStorage.storage().reference().child("audios").child("\(snap.audioID).m4a").delete(completion: {(error) in
                print("Se eliminó correctamente el audio")
            })
    }

    
    //Reproducir el audio
    @IBAction func audioPlayTapped(_ sender: Any) {
        
       
        
        let pathString = snap.audioID
        let storageReference = FIRStorage.storage().reference().child("audios").child("\(pathString).m4a")
        let fileUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let fileUrl = fileUrls.first?.appendingPathComponent(pathString) else {
            return
        }
        
        let downloadTask = storageReference.write(toFile: fileUrl)
        
        downloadTask.observe(.success) { _ in
            do {
                self.player = try AVAudioPlayer(contentsOf: fileUrl)
                self.player?.prepareToPlay()
                self.player?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
   

}
